class SearchModel {
bool? status;
String? message;
SearchData? data;

SearchModel.fromJson(Map<String, dynamic> json) {
status = json['status'];
message = json['message'];
data = json['data'] != null ? SearchData.fromJson(json['data']) : null;
}


}

class SearchData {
int? currentPage;
List<Data>? data;


SearchData.fromJson(Map<String, dynamic> json) {
currentPage = json['current_page'];
if (json['data'] != null) {
data = <Data>[];
json['data'].forEach((v) {
data!.add(Data.fromJson(v));
});
}
}

}

class Data {
  late int id;
dynamic price;
dynamic oldPrice;
dynamic discount;
String? image;
String? name;
late String description;
bool? inFavorites;
bool? inCart;
late List<String> images;


Data.fromJson(Map<String, dynamic> json) {
id = json['id'];
price = json['price'];
oldPrice = json['old_price'];
discount = json['discount'];
image = json['image'];
name = json['name'];
description = json['description'];
inFavorites = json['in_favorites'];
inCart = json['in_cart'];
images = json['images'].cast<String>();
}


}