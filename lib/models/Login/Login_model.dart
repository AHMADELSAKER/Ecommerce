
class shoploginmodel {
  bool? status;
  String? message;
  usermodle? data;
  shoploginmodel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? usermodle.fromjson(json['data']) : null;
  }
}

class usermodle {
  String? name;
  String? phone;
  String? email;
  int? id;
  String? image;
  String? token;
  usermodle.fromjson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}
