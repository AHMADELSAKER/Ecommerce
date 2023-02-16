import 'package:ecommers/layout/Shop/Cubit/Cubit.dart';
import 'package:ecommers/layout/Shop/Cubit/States.dart';
import 'package:ecommers/modules/Shop-app/login/shop-login-screen.dart';
import 'package:ecommers/shared/component/Constants.dart';
import 'package:ecommers/shared/component/components.dart';
import 'package:ecommers/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/Shop-app/Searchscreen/Searchscreen.dart';

class Shop_layout_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShophomeStates>(
        builder: (context, state) {
          var cubit = ShopHomeCubit.get(context);
          return Scaffold(
              // appBar: AppBar(
              //   backgroundColor: Colors.white,
              //   elevation: 0,
              //   actions: [
              //     IconButton(
              //       onPressed: () {
              //         navigateTo(context: context, widget: Searchscreen());
              //       },
              //       icon: Icon(
              //         Icons.search,
              //       ),
              //       iconSize: 30,
              //       color: Colors.grey.shade600,
              //     )
              //   ],
              // ),
              body: cubit.BottomScreen[cubit.Currentindext!],
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey.shade600,
                showUnselectedLabels: true,

                // unselectedLabelStyle: TextStyle(
                //   color: Colors.black,
                //   fontSize: 20,
                // ),
                items: [
                  BottomNavigationBarItem(
                      backgroundColor: Color.fromARGB(255, 187, 212, 255),
                      icon: Icon(Icons.apps),
                      label: 'Categories'),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: ('Settings'),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: 'Search'),
                ],
                onTap: (int index) {
                  cubit.Changebottomnavigate(index);
                },
                currentIndex: cubit.Currentindext ?? 0,
              ));
        },
        listener: (context, state) {});
  }
}
