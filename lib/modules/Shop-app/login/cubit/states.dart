import 'package:ecommers/models/login/Login_model.dart';

abstract class shoploginstates {}

// ignore: camel_case_types
class shoplogininitaialstate extends shoploginstates {}

class shoploginloadingstate extends shoploginstates {}

class shoploginerrorstate extends shoploginstates {
  String error;
  shoploginerrorstate(this.error);
}

class shoploginsucssesstate extends shoploginstates {
  final shoploginmodel? loginmodel;
  shoploginsucssesstate({this.loginmodel});
}

class shoploginchangepasswordvisivilty extends shoploginstates {}
