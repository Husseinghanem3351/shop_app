
class HomeModel{
  late String? message;
  late bool status;
  late HomeData? data;

  HomeModel.fromJson(Map<String,dynamic>? json){
    message=json!['message'];
    status=json['status'];
    data=(json['data']!=null?HomeData.fromJson(json['data']):null);
  }
}

class HomeData{

  late List<BannersModel>? banners=[];
  late List<ProductsModel> products=[];

  HomeData.fromJson(Map < String ,dynamic > json){
    json['banners'].forEach((element){
      banners!.add(BannersModel.fromJson(element));
    });

    json['products'].forEach((element){
      products.add(ProductsModel.fromJson(element));
    });
     }
  }


class BannersModel {
  late int id;
  late String image;


  BannersModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}
class ProductsModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;
  late dynamic description;
  late List<String> images;

  ProductsModel.fromJson(Map<String,dynamic> json){
   id=json['id'];
   price=json['price'];
   oldPrice=json['old_price'];
   discount=json['discount'];
   image=json['image'];
   name=json['name'];
   inFavorites=json['in_favorites'];
  inCart=json['in_cart'];
   description=json['description'];
   images = json['images'].cast<String>();
  }
}