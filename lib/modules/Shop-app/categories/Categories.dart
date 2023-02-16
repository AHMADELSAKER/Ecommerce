import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommers/layout/Shop/Cubit/Cubit.dart';
import 'package:ecommers/layout/Shop/Cubit/States.dart';
import 'package:ecommers/models/CategoriesModel/CategoriesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShophomeStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopHomeCubit.get(context).categoriesModel != null,
              builder: (context) => Scaffold(
                    body: ListView.separated(
                      itemBuilder: (context, index) => CatScreenBuilder(
                          ShopHomeCubit.get(context)
                              .categoriesModel!
                              .data!
                              .data[index]),
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        thickness: 0.3,
                        color: Color.fromARGB(255, 73, 73, 73),
                      ),
                      itemCount: ShopHomeCubit.get(context)
                          .categoriesModel!
                          .data!
                          .data
                          .length,
                    ),
                  ),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        },
        listener: (context, state) {});
  }

  Widget CatScreenBuilder(DataModel model) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 111,
              height: 111,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(
                      model.image.toString(),
                    ),
                    fit: BoxFit.fill,
                  )),
              // child: Image(
              //   image: NetworkImage(model.image.toString()),
              //   fit: BoxFit.fill,
              //   width: 100,
              //   height: 100,
              // ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              model.name.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 30,
            )
          ],
        ),
      );
}
