import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommers/models/FavoriteModel/FavoriteModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/Shop/Cubit/Cubit.dart';
import '../../../layout/Shop/Cubit/States.dart';
import '../../../shared/network/style/Colors.dart';

class FavoriteScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShophomeStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: ShopHomeCubit.get(context).favoritesModel != null,
              builder: (context) => Scaffold(
                    body: ListView.separated(
                      itemBuilder: (context, index) => buildFavoriteItem(
                          ShopHomeCubit.get(context)
                              .favoritesModel!
                              .data!
                              .data![index],
                          context),
                      separatorBuilder: (context, index) => Divider(
                        height: 2,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      itemCount: ShopHomeCubit.get(context)
                          .favoritesModel!
                          .data!
                          .data!
                          .length,
                    ),
                  ),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        },
        listener: (context, state) {});
  }

  Widget buildFavoriteItem(model, context) {
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
}
