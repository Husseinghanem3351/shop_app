import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app_layout/cubit/states.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shop_app/Shop_Login/Shop_Login.dart';
import '../../../shop_app/categories/categories.dart';
import '../../../shop_app/favorites/favorites.dart';
import '../../../shop_app/products/products.dart';
import '../../../shop_app/setting/setting.dart';
import '../../../shop_app_models/CartModel.dart';
import '../../../shop_app_models/Favorites_model.dart';
import '../../../shop_app_models/categories_model.dart';
import '../../../shop_app_models/change_favorites_model.dart';
import '../../../shop_app_models/home_model.dart';
import '../../../shop_app_models/post_cart.dart';
import '../../../shop_app_models/profile_model.dart';
import '../../../shop_app_models/search_model.dart';

class ShopCubit extends Cubit<ShopLayoutState> {
  ShopCubit() : super(ShopLayoutInitialState());

  List<Widget> bottomList = [
    const Products(),
    const Categories(),
    const Favorites(),
    const SettingScreen(),
  ];
  int currentIndex = 0;
  HomeModel? homeModel;
  SearchModel? searchModel;
  CategoriesModel? categoriesModel;
  late ChangeFavoritesModel changeFavoritesModel;
  late Map<int?, bool> isInFavorites = {};
  late Map<int?, bool> isInCart = {};
  GetFavoritesModel? getFavoritesModel;
  IconData darkSettingIcon = Icons.dark_mode_outlined;

  static ShopCubit get(context) => BlocProvider.of(context);

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopLayoutChangeBottomNavState());
  }

  void getHomeData() {
    emit(ShopHomeLoadingDataState());
    DioHelper.getData(
      url: homeUrl,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        isInFavorites.addAll({element.id: element.inFavorites});
        isInCart.addAll({element.id: element.inCart});
      }
      emit(ShopHomeSuccessDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ShopHomeErrorDataState());
    });
  }

  void getSearchData(search) {
    emit(ShopSearchLoadingDataState());
    DioHelper.postData(
      url: searchURL,
      token: token,
      data: {'text': search},
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessDataState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ShopSearchErrorDataState());
    });
  }

  void getCategoriesData() {
    DioHelper.getData(
      url: getCategories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ShopCategoriesErrorState());
    });
  }

  void postFavorites(int? id) {
    isInFavorites[id!] = !isInFavorites[id]!;
    emit(ChangeIsFavoritePressedState());
    DioHelper.postData(
      url: favorites,
      data: {'product_id': id},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel.status) {
        isInFavorites[id] = !isInFavorites[id]!;
      } else {
        getFavorites();
      }
      emit(ChangeIsFavoriteSuccessState(changeFavoritesModel));
      // if(changeFavoritesModel.status==true){
      //   showMsg(msg: changeFavoritesModel.message, state: ToastStates.success);
      // }
      // else{
      //   showMsg(msg: changeFavoritesModel.message, state: ToastStates.warning);

      // }
      // if (kDebugMode) {
      //   print(value);
      // }
    }).catchError((error) {
      isInFavorites[id] = !isInFavorites[id]!;
      emit(ChangeIsFavoriteErrorState(changeFavoritesModel));
    });
  }

  void getFavorites() {
    emit(GetLoadingFavoritesState());
    DioHelper.getData(
      url: favorites,
      token: token,
    ).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      emit(GetFavoritesSuccess());
    }).catchError((error) {
      emit(GetFavoritesError());
      if (kDebugMode) {
        print(error);
      }
    });
  }

  void favoritesOnPressed(Product? model) {
    postFavorites(model?.id);
  }

  void signOut(context) {
    CacheHelper.removeData('token');
    emit(DeleteShopData());
    pushAndReplacement(context, widget: ShopLogin());
  }

  ProfileModel? profileModel;

  void getProfile() {
    emit(GetProfileLoading());
    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      //print(profileModel.data);
      emit(GetProfileSuccess());
    }).catchError((error) {
      emit(GetProfileError());
      if (kDebugMode) {
        print(error);
      }
    });
  }

  void updateProfile({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(UpdateProfileLoading());
    DioHelper.updateData(
      url: updateProfileUrl,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      },
      token: token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      if (profileModel!.status) {
        emit(UpdateProfileSuccess());
        // showMsg(msg: profileModel!.message??'',
        //   state: ToastStates.success,
        // );
      } else {
        // showMsg(msg: profileModel!.message??'',
        //   state: ToastStates.warning,
        // );
      }
    }).catchError((error) {
      emit(UpdateProfileError());
      // showMsg(msg: profileModel!.message??'',
      //   state: ToastStates.error,
      // );
      if (kDebugMode) {
        print(error);
      }
    });
  }

  void pressUpdateUnValidate(String name, String phone, String email, context) {
    name = ShopCubit.get(context).profileModel!.data?.name ?? '';
    phone = ShopCubit.get(context).profileModel!.data?.phone ?? '';
    email = ShopCubit.get(context).profileModel!.data?.email ?? '';
    emit(UpdateUnValidateState());
  }

  CartModel? cartModel;

  void getCart() {
    //cartModel=null;
    //emit(GetCartLoadingState());
    DioHelper.getData(
      url: cart,
      token: token,
    ).then((value) {
      emit(GetCartSuccessState());
      cartModel = CartModel.fromJson(value.data);
      print(value);
    }).catchError((error) {
      emit(GetCartErrorState());
      if (kDebugMode) {
        print(error);
      }
    });
  }

  PostCart? postData;
  void removeOrAddCart(int? id) {
    cartModel = null;
    emit(PostCartLoadingState());
    DioHelper.postData(
      url: cart,
      token: token,
      data: {
        "product_id": id,
      },
    ).then((value) {
      getCart();
      postData = PostCart.fromJson(value.data??'');
      // showMsg(msg: postData!.message ?? '', state: ToastStates.success);
      getHomeData();
      getSearchData('');
      emit(PostCartSuccessState());
    }).catchError((error) {
      emit(PostCartErrorState());
      if (kDebugMode) {
        print(error);
      }
    });
  }


  bool isDark = false;

  void changeDarkMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeDarkModeState());
      });
    }
  }

}
