// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../layout/Shop/Cubit/Cubit.dart';
import '../network/style/Colors.dart';

void navigateTo({
  required context,
  required widget,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigatoandremove({
  required context,
  required widget,
}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );
// void showtoast({
//   @required String? msg,
//   ToastState? state,
// }) =>
//     Fluttertoast.showToast(
//         msg: msg!,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: ChooseToastColor(state!),
//         textColor: Colors.white,
//         fontSize: 16.0);

enum ToastState { Succses, Error, Warning }
Color ChooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.Succses:
      color = Colors.green;
      break;
    case ToastState.Warning:
      color = Colors.yellow;
      break;
    case ToastState.Error:
      color = Colors.red;
      break;
  }
  return color;
}

Widget buildListItem(model, context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 120,
          height: 120,
          child: Stack(children: [
            Image(
              // image: AssetImage('assets/images/onboard1.png'),
              image: NetworkImage(model.product!.image.toString()),

              width: 200,
              fit: BoxFit.cover,
              height: 200,
            ),
            if (model.product!.discount != null)
              if (model.product!.price != model.product!.oldPrice)
                Container(
                  child: Text(
                    'Discount',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                )
          ]),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                model.product!.name.toString(),
                style:
                    TextStyle(fontSize: 15, height: 1.1, color: Colors.black),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.product!.price.toString(),
                    style: TextStyle(
                        fontSize: 18, height: 1.1, color: Defaultcolor),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (model.product!.discount != null)
                    if (model.product!.price != model.product!.oldPrice)
                      Text(
                        model.product!.oldPrice.toString(),
                        style: TextStyle(
                            fontSize: 13,
                            height: 1.1,
                            decoration: TextDecoration.lineThrough),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                  Spacer(),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: true ? Colors.cyan : Colors.grey,
                    child: IconButton(
                        onPressed: () {
                          ShopHomeCubit.get(context)
                              .ChangFavorites(model.product!.id);
                        },
                        icon: Icon(
                          Icons.favorite_outline,
                          size: 14.5,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    ),
  );
}

Widget ContainerWithDecoration() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.redAccent, Colors.white, Colors.blue]),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
          )),
    );
