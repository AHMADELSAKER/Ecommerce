import 'package:ecommers/layout/Shop/Cubit/States.dart';
import 'package:ecommers/models/CategoriesModel/CategoriesModel.dart';
import 'package:ecommers/models/ShopHomeData/HomeModel.dart';
import 'package:ecommers/models/login/Login_model.dart';
import 'package:ecommers/modules/Shop-app/Searchscreen/Searchscreen.dart';
import 'package:ecommers/modules/Shop-app/categories/Categories.dart';
import 'package:ecommers/modules/Shop-app/favorites/favorites.dart';
import 'package:ecommers/modules/Shop-app/settings/Settings.dart';
import 'package:ecommers/shared/component/Constants.dart';
import 'package:ecommers/shared/network/remote/dio_helper.dart';
import 'package:ecommers/shared/network/remote/end_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/FavoriteModel/FavoriteModel.dart';
import '../../../modules/Shop-app/Products/Product_home_Screen.dart';

// ignore: camel_case_types
class ShopHomeCubit extends Cubit<ShophomeStates> {
  ShopHomeCubit() : super(shopHomeinitaialstate());

  static ShopHomeCubit get(context) => BlocProvider.of(context);
  int? Currentindext = 0;
  List<Widget> BottomScreen = [
    CategoriesScreen(),
    FavoriteScreen(),
    ProductHomeScreen(),
    SettingScreen(),
    Searchscreen(),
  ];
  void Changebottomnavigate(int index) {
    Currentindext = index;
    emit(ChangebottomnavigationState());
  }

  HomeModel? homeModel;
  Map<int?, bool?> Favorite = {};
  void GetHomeData() async {
    emit(shophomeloadingstate());
    await DioHelper.getdata(
      url: Home,
      token: token,
    ).then((value) {
      emit(shophomesuccessState());
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.Products.forEach((element) {
        Favorite.addAll({
          element.id!: element.in_favorites,
        });
      });
      print('================Favorite Map============');
      print(Favorite.toString());
    }).catchError((e) {
      emit(shophomeErrorstate());
      print(e);
    });
  }

  CategoriesModel? categoriesModel;
  void GetCategoriesData() async {
    await DioHelper.getdata(
      url: Categorie,
      token: token,
    ).then((value) {
      emit(shopCategoriessuccessState());
      categoriesModel = CategoriesModel.fromjson(value.data);
    }).catchError((e) {
      emit(shopCategoriesErrorstate());
      print('===========Error in CategoresModel=========');
      print(e);
    });
  }

  ChangeFavoriteModel? changefavoritmodel;
  void ChangFavorites(int? Product_id) {
    Favorite[Product_id] = !Favorite[Product_id]!;
    emit(shopChangeFavoritesuccessState());
    DioHelper.postdata(url: FavoriteAPi, token: token, data: {
      'product_id': Product_id,
    }).then((value) {
      // print(token);
      changefavoritmodel = ChangeFavoriteModel.fromjson(value.data);
      print('======================value.data in ChangeFavoritesModel=====');
      print(value.data.toString());
      if (!changefavoritmodel!.status!) {
        Favorite[Product_id] = !Favorite[Product_id]!;
      } else {
        GetFaveItem();
      }
      ;
      emit(shopFavoritesuccessState(changefavoritmodel));
    }).catchError((e) {
      Favorite[Product_id] = !Favorite[Product_id]!;
      emit(shopFavoriteErrorstate());
    });
  }

  FavoritesModel? favoritesModel;
  void GetFaveItem() {
    emit(shoploadingGetFavoritesuccessState());
    DioHelper.getdata(url: FavoriteAPi, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(shopGetFavessuccessState());
    }).catchError((e) {
      emit(shopGetFavErrorstate());
    });
  }

  shoploginmodel? UserData;
  void GetUserData() {
    emit(shoploadingGetUserdatasuccessState());
    DioHelper.getdata(url: ProfileApi, token: token).then((value) {
      UserData = shoploginmodel.fromjson(value.data);
      print(UserData!.data!.name);
      emit(shopGetUserdatassuccessState(UserData));
    }).catchError((e) {
      emit(shopGetUserdataErrorstate());
    });
  }
}
