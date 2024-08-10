

import '../../../shop_app_models/login_model.dart';

abstract class ShopRegisterState{}

class ShopRegisterInitialState extends ShopRegisterState{}

class ShopRegisterLoadingState extends ShopRegisterState{}

class ShopRegisterErrorState extends ShopRegisterState{
  String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterSuccessState extends ShopRegisterState{
 late final LoginModel registerModel;

 ShopRegisterSuccessState(this.registerModel);
}

class ChangeVisibilityState extends ShopRegisterState{}

class RegisterSuccessState extends ShopRegisterState{}

class RegisterErrorState extends ShopRegisterState{}