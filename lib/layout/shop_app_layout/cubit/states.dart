

import '../../../shop_app_models/change_favorites_model.dart';

abstract class ShopLayoutState{}

class ShopLayoutInitialState extends ShopLayoutState{}

class ShopLayoutChangeBottomNavState extends ShopLayoutState{}

class ShopHomeLoadingDataState extends ShopLayoutState{}

class ShopHomeSuccessDataState extends ShopLayoutState{}

class ShopHomeErrorDataState extends ShopLayoutState{
  ShopHomeErrorDataState();
}

class ShopCategoriesSuccessState extends ShopLayoutState{}

class ShopCategoriesErrorState extends ShopLayoutState{
  ShopCategoriesErrorState();
}

class CreateShopDataBase extends ShopLayoutState{}

class UpdateShopData extends ShopLayoutState{}

class InsertToDatabaseShop extends ShopLayoutState{}

class LoadingShopDataFromDatabase extends ShopLayoutState{}

class GetShopFromDatabase extends ShopLayoutState{}

class DeleteShopData extends ShopLayoutState{}

class ChangeIsFavoriteErrorState extends ShopLayoutState{
  late final ChangeFavoritesModel model;
  ChangeIsFavoriteErrorState(this.model);
}

class ChangeIsFavoriteSuccessState extends ShopLayoutState{
  late final ChangeFavoritesModel model;
  ChangeIsFavoriteSuccessState(this.model);
}

class ChangeIsFavoritePressedState extends ShopLayoutState{}

class GetFavoritesSuccess extends ShopLayoutState{}

class GetFavoritesError extends ShopLayoutState{}

class GetLoadingFavoritesState extends ShopLayoutState{}

class GetProfileLoading extends ShopLayoutState{}

class GetProfileSuccess extends ShopLayoutState{}

class GetProfileError extends ShopLayoutState{}

class UpdateProfileLoading extends ShopLayoutState{}

class UpdateProfileSuccess extends ShopLayoutState{}

class UpdateProfileError extends ShopLayoutState{}

class RegisterSuccessState extends ShopLayoutState{}

class RegisterErrorState extends ShopLayoutState{}

class ChangeVisibilityState extends ShopLayoutState{}

class UpdateUnValidateState extends ShopLayoutState{}

class ShopSearchLoadingDataState extends ShopLayoutState{}

class ShopSearchSuccessDataState extends ShopLayoutState{}

class ShopSearchErrorDataState extends ShopLayoutState{}

class GetCartSuccessState extends ShopLayoutState{}

class GetCartErrorState extends ShopLayoutState{}

class GetCartLoadingState extends ShopLayoutState{}

class PostCartSuccessState extends ShopLayoutState{}

class PostCartErrorState extends ShopLayoutState{}

class PostCartLoadingState extends ShopLayoutState{}

class ChangeQuantityState extends ShopLayoutState{}

class ChangeDarkModeState extends ShopLayoutState{}
