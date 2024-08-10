import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app_layout/Shop_Layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shop_app/Shop_Login/cubit/states.dart';
import '../../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shop_app_models/login_model.dart';


class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit():super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=> BlocProvider.of(context);

  late LoginModel loginModel;


  void  userLogin(BuildContext context,String email,String password){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: loginUrl,
        data: {
          'email':email,
          'password':password,
        },
        lang: 'en',
        ).then((value) {
        loginModel=LoginModel.fromJson(value.data);
        token=loginModel.data?.token;
        CacheHelper.putData(key: 'token', value: 'token');
        navigateTo(context, widget: const Shop_Layout());
        emit(ShopLoginSuccessState(loginModel));
        }).catchError((value){
          print(value);
          emit(ShopLoginErrorState(value.toString()));
        });
  }


  IconData passIcon=Icons.visibility;
  bool isPass=false;

  void changePassIcon(){
      isPass=!isPass;
      passIcon=isPass?Icons.visibility_off:Icons.visibility;
      emit(ChangeVisibilityState());
  }


}