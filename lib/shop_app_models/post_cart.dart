class PostCart {
  bool? status;
  String? message;

  PostCart.fromJson(Map<String, dynamic> json){
    status=json['status'];
    message=json['message'];
  }
 }