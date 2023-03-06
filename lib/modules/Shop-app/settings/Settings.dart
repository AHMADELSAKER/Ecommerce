import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommers/layout/Shop/Cubit/Cubit.dart';
import 'package:ecommers/layout/Shop/Cubit/States.dart';
import 'package:ecommers/shared/component/Constants.dart';
import 'package:ecommers/shared/component/default-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/component/default_formfield.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var emailcontroller = TextEditingController();

  var phonecontroller = TextEditingController();

  var passcontroller = TextEditingController();

  var namecontroller = TextEditingController();

  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShophomeStates>(
        builder: (context, State) {
          var model = ShopHomeCubit.get(context).UserData;
          namecontroller.text = model!.data!.name!;
          emailcontroller.text = model.data!.email!;
          phonecontroller.text = model.data!.phone!;
          return ConditionalBuilder(
              condition: ShopHomeCubit.get(context).UserData != null,
              builder: (context) => BuildSettingScreen(),
              fallback: (context) => CircularProgressIndicator());
        },
        listener: (context, State) => {});
  }

  Widget BuildSettingScreen() => Container(
        margin: EdgeInsets.only(top: 100),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'User Data',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20,
                ),
                DefaultFormField(
                    controller: namecontroller,
                    type: TextInputType.name,
                    label: 'User Name',
                    prefix: Icons.person,
                    valdiate: (String? value) {
                      if (value == null) {
                        print('Please Enter Your Email');
                      }
                      return null;
                    },
                    ispassword: false),
                SizedBox(
                  height: 15,
                ),
                DefaultFormField(
                    controller: emailcontroller,
                    type: TextInputType.emailAddress,
                    label: 'Email Address',
                    prefix: Icons.email,
                    valdiate: (String? value) {
                      if (value! == null) {
                        print('Please Enter Your Email');
                      }
                    },
                    ispassword: false),
                SizedBox(
                  height: 15,
                ),
                DefaultFormField(
                    controller: phonecontroller,
                    type: TextInputType.phone,
                    label: 'Phone Number',
                    prefix: Icons.phone,
                    valdiate: (String? value) {
                      if (value == null) {
                        print('Please Enter Your Phone');
                      }
                      return null;
                    },
                    ispassword: false),
                SizedBox(
                  height: 100,
                ),
                DefaultButton(
                  function: () {},
                  // function: (context) {
                  //   SignOut(context);
                  // },
                  text: 'Log Out',
                  backroundcolor: Colors.blueAccent,
                )
              ],
            ),
          ),
        ),
      );
}
