import '../../../shop_app_models/login_model.dart';

abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLoadingState extends ShopLoginState{}

class ShopLoginErrorState extends ShopLoginState{
  String error;
  ShopLoginErrorState(this.error);
}

class ShopLoginSuccessState extends ShopLoginState{
 late final LoginModel loginModel;

 ShopLoginSuccessState(this.loginModel);
}

class ChangeVisibilityState extends ShopLoginState{}

class RegisterSuccessState extends ShopLoginState{}

class RegisterErrorState extends ShopLoginState{}