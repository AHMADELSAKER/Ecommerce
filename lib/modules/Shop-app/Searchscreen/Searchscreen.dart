import 'package:ecommers/models/SearchModel/CubitSearch/Cubit.dart';
import 'package:ecommers/models/SearchModel/CubitSearch/States.dart';
import 'package:ecommers/shared/component/default_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommers/modules/Shop-app/favorites/favorites.dart';

import '../../../layout/Shop/Cubit/Cubit.dart';
import '../../../shared/component/components.dart';

class Searchscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchcontroller = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          builder: ((context, state) {
            return Scaffold(
              body: Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(children: [
                    DefaultFormField(
                        onsubmit: (String? text) {
                          SearchCubit.get(context).Getsearch(text);
                        },
                        ispassword: false,
                        controller: searchcontroller,
                        type: TextInputType.text,
                        label: 'Search',
                        prefix: Icons.search,
                        valdiate: (String value) {
                          if (value.isEmpty) {
                            return 'Search What Do You Want';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    if (state is Searchloadingstate) LinearProgressIndicator(),
                    if (state is SearchsuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListItem(
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
                  ]),
                ),
              ),
            );
          }),
          listener: (context, state) => {}),
    );
  }
}
