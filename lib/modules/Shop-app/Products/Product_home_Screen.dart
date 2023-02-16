import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommers/layout/Shop/Cubit/Cubit.dart';
import 'package:ecommers/layout/Shop/Cubit/States.dart';
import 'package:ecommers/models/CategoriesModel/CategoriesModel.dart';
import 'package:ecommers/models/ShopHomeData/HomeModel.dart';
import 'package:ecommers/shared/network/style/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShophomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopHomeCubit.get(context).homeModel != null &&
              ShopHomeCubit.get(context).categoriesModel != null &&
              ShopHomeCubit.get(context).homeModel!.data!.Banners[0].image !=
                  null,
          builder: (context) => ProductBuilder(
              context,
              ShopHomeCubit.get(context).homeModel,
              ShopHomeCubit.get(context).categoriesModel!),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget ProductBuilder(
    context,
    HomeModel? model,
    CategoriesModel catmodel,
  ) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model!.data!.Banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image.toString()),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 3),
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            CategoriesBuilder(catmodel.data!.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        itemCount: catmodel.data!.data.length),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Container(
              // decoration: BoxDecoration(
              color: Color.fromARGB(255, 180, 212, 216),
              // borderRadius: BorderRadius.circular(50)),
              child: GridView.count(
                padding: EdgeInsets.all(0),
                childAspectRatio: 1 / 1.37,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 2.0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                  model.data!.Products.length,
                  (index) =>
                      BuildGridProduct(model.data!.Products[index], context),
                ),
              ),
            )
          ],
        ),
      );

  Widget BuildGridProduct(ProductModel model, context) => Padding(
        padding: const EdgeInsets.only(
          left: 1,
        ),
        child: Container(
          color: Colors.white,
          child: Column(children: [
            Stack(children: [
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                fit: BoxFit.fill,
                height: 200,
              ),
              if (model.discount != null)
                if (model.price != model.old_price)
                  Container(
                    child: Text(
                      'Discount',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                  )
            ]),
            Padding(
              padding: EdgeInsetsDirectional.all(8),
              child: Column(
                children: [
                  Text(
                    model.name.toString(),
                    style: TextStyle(
                        fontSize: 15, height: 1.1, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                            fontSize: 18, height: 1.1, color: Defaultcolor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (model.discount != null)
                        if (model.price != model.old_price)
                          Text(
                            model.old_price.toString(),
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
                        backgroundColor:
                            ShopHomeCubit.get(context).Favorite[model.id]!
                                ? Colors.cyan
                                : Colors.grey,
                        child: IconButton(
                            onPressed: () {
                              ShopHomeCubit.get(context)
                                  .ChangFavorites(model.id);
                              print(model.id);
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

  Widget CategoriesBuilder(DataModel model) => Container(
        width: 100,
        height: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(model.image.toString()),
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
            Container(
              width: double.infinity,
              color: Colors.black.withOpacity(.5),
              child: Text(
                model.name.toString(),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
}
