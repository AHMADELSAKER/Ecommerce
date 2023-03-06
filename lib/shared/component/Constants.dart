import 'package:ecommers/shared/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';

import '../../modules/Shop-app/login/shop-login-screen.dart';
import 'components.dart';

void SignOut(context) {
  print('object');
  cachehelper.Removedata('token').then((value) {
    if (value) {
      navigatoandremove(context: context, widget: Shoplogin());
    }
  });
}

void PrintFullText(String? text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match) {
    print(match.group(0));
  });
}

String? token;
