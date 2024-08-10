class CategoriesModel{
  late bool status;
  late CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data =(CategoriesDataModel.fromJson(json));
  }
}

class CategoriesDataModel {
late List<DataModel> data=[];
late int? currentPage;
CategoriesDataModel.fromJson(Map<String,dynamic> json){
json['data']['data'].forEach((element){
  data.add(DataModel.fromJson(element));
});
currentPage=json['current_page'];
}
}

class DataModel{
  late int? id;
  late String image;
  late String name;
  DataModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    image=json['image'];
    name=json['name'];
  }
}