// ignore_for_file: unused_import

import 'dart:convert';

import 'package:ecommers/models/login/Login_model.dart';
import 'package:ecommers/modules/Shop-app/login/cubit/states.dart';
import 'package:ecommers/shared/network/remote/end_point.dart';
import 'package:ecommers/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types
class shoplogincubit extends Cubit<shoploginstates> {
  shoplogincubit() : super(shoplogininitaialstate());

  static shoplogincubit get(context) => BlocProvider.of(context);
  shoploginmodel? loginmodle;
  void Userlogin({
    required String password,
    required String email,
  }) {
    emit(shoploginloadingstate());
    DioHelper.postdata(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginmodle = shoploginmodel.fromjson(value.data);
      print('111111111111111111111');
      emit(shoploginsucssesstate(loginmodel: loginmodle));
      print(loginmodle!.status);
    }).catchError((onError) {
      emit(shoploginerrorstate(onError.toString()));
      print('========${onError}=============================');
    });
  }

  IconData? suffix = Icons.visibility_outlined;
  bool? ispassword = true;
  void changepasswordvisibilty() {
    ispassword = !ispassword!;
    suffix =
        ispassword! ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(shoploginchangepasswordvisivilty());
  }
}
