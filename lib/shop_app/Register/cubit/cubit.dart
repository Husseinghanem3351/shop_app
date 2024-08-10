import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app_layout/Shop_Layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shop_app/Register/cubit/states.dart';


import '../../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shop_app_models/login_model.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterState>{
  ShopRegisterCubit():super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=> BlocProvider.of(context);

  late LoginModel registerModel;


  void  userRegister(
  context,{
     required String name,
    required String phone,
     required String password,
    required String email,}
      ){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: registerUrl,
        data: {
          'name':name,
        'phone':phone,
        'email':email,
        'password':password,
        },
        ).then((value) {
        registerModel=LoginModel.fromJson(value.data);
        token=registerModel.data?.token;
        CacheHelper.putData(key: 'token', value: 'token');
        navigateTo(context, widget: const Shop_Layout());
        emit(ShopRegisterSuccessState(registerModel));
        print('success register $value');
        }).catchError((value){
          print('error register $value');
          emit(ShopRegisterErrorState(value.toString()));
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

//void register(context,{
//     required String name,
//     required String phone,
//     required String password,
//     required String email,
// }){
//   DioHelper.postData(
//       url: registerUrl,
//       data: {
//         'name':name,
//         'phone':phone,
//         'email':email,
//         'password':password,
//       },
//   ).then((value) {
//     pushAndReplacement(context,widget: ShopLogin());
//     emit(RegisterSuccessState());
//   }).catchError((error){
//     print(error);
//     emit(RegisterErrorState());
//   });
//   }