class GetFavoritesModel {
  bool? status;
  String? message;
  FavoritesData? data;


  GetFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? FavoritesData.fromJson(json['data']) : null;
  }

}

class FavoritesData {
  int? currentPage;
  List<Data>? data;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  Product? product;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null ?  Product.fromJson(json['product']) : null;
  }

}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool? inFavorites;
  late bool? inCart;
  dynamic description;

  Product.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
    description=json['description'];
  }

}