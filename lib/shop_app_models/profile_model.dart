class ProfileModel{
  late String? message;
  late bool status;
  late UserData? data;
  // LoginModel(
  //     {required this.data,
  //       required this.message,
  //       required this.status,}
  //     );
  ProfileModel.fromJson(Map<String,dynamic> json){
    message=json['message'];
    status=json['status'];
    data=(json['data']!=null?UserData.fromJson(json['data']):null);
  }
}

class UserData{
  int? id;
  String? email;
  String? name;
  String? phone;
  String? imageUrl;
  int? points;
  int? credit;
  String? token;
  // UserData(
  //     { this.token,
  //        this.imageUrl,
  //        this.id,
  //        this.credit,
  //        this.email,
  //        this.name,
  //        this.phone,
  //        this.points}
  //     );

  UserData.fromJson(
      Map<String,dynamic> json)
  {
    name=json['name'];
    token=json['token'];
    points=json['points'];
    phone=json['phone'];
    email=json['email'];
    credit=json['credit'];
    id=json['id'];
    imageUrl=json['imageUrl'];
  }
}