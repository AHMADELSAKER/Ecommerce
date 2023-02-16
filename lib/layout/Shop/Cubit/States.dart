import 'package:ecommers/models/FavoriteModel/FavoriteModel.dart';
import 'package:ecommers/models/login/Login_model.dart';
import 'package:ecommers/layout/Shop/Cubit/Cubit.dart';

abstract class ShophomeStates {}

// ignore: camel_case_types
class shopHomeinitaialstate extends ShophomeStates {}

class shophomeloadingstate extends ShophomeStates {}

class shophomesuccessState extends ShophomeStates {}

class shophomeErrorstate extends ShophomeStates {
  String? error;
  shophomeErrorstate({this.error});
}

class shopCategoriessuccessState extends ShophomeStates {}

class shopCategoriesErrorstate extends ShophomeStates {}

class shoploginsucssesstate extends ShophomeStates {
  final shoploginmodel? loginmodel;
  shoploginsucssesstate({this.loginmodel});
}

class ChangebottomnavigationState extends ShophomeStates {}

class shopFavoritesuccessState extends ShophomeStates {
  final ChangeFavoriteModel? model;
  shopFavoritesuccessState(this.model);
}

class shopChangeFavoritesuccessState extends ShophomeStates {}

class shopFavoriteErrorstate extends ShophomeStates {
  String? error;
  shopFavoriteErrorstate({this.error});
}

class shopGetFavessuccessState extends ShophomeStates {}

class shopGetFavErrorstate extends ShophomeStates {}

class shoploadingGetFavoritesuccessState extends ShophomeStates {}

class shopGetUserdatassuccessState extends ShophomeStates {
  final shoploginmodel? UserModel;
  shopGetUserdatassuccessState(this.UserModel);
}

class shopGetUserdataErrorstate extends ShophomeStates {}

class shoploadingGetUserdatasuccessState extends ShophomeStates {}
