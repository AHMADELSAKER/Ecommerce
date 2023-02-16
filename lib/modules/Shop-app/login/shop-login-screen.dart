// ignore_for_file: avoid_types_as_parameter_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommers/layout/Shop/Shop_layout.dart';
import 'package:ecommers/modules/Shop-app/Register/registerscreen.dart';
import 'package:ecommers/shared/component/Constants.dart';
import 'package:ecommers/shared/component/components.dart';
import 'package:ecommers/shared/component/default-button.dart';
import 'package:ecommers/shared/component/default_formfield.dart';
import 'package:ecommers/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class Shoplogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passcontroller = TextEditingController();

    return BlocProvider(
        create: (context) => shoplogincubit(),
        child: BlocConsumer<shoplogincubit, shoploginstates>(
            listener: (context, state) {
          if (state is shoploginsucssesstate) {
            if (state.loginmodel!.status!) {
              print(state.loginmodel!.message);
              print(state.loginmodel!.data!.token);
              cachehelper.Savedata(
                      key: 'token', value: state.loginmodel!.data!.token)
                  .then((value) {
                token = state.loginmodel!.data!.token!;
                navigatoandremove(
                    context: context, widget: Shop_layout_screen());
              });
            } else {
              print(state.loginmodel!.message);
              // showtoast(
              //     msg: state.loginmodel!.message, state: ToastState.Error);
            }
          }
        }, builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Text('LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(
                                    inherit: true,
                                    fontWeight: FontWeight.bold)),
                        Text(
                          'Login to get Abeautifull offers',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(inherit: true, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DefaultFormField(
                          suffixpressed: () {},
                          controller: emailcontroller,
                          type: TextInputType.emailAddress,
                          label: 'Email Address ',
                          prefix: Icons.email_outlined,
                          valdiate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email';
                            }
                            ;
                          },
                          ispassword: false,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: shoplogincubit.get(context).ispassword!,
                          controller: passcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            label: Text('Password'),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  shoplogincubit
                                      .get(context)
                                      .changepasswordvisibilty();
                                },
                                icon: Icon(shoplogincubit.get(context).suffix)),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.redAccent, width: 5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! shoploginloadingstate,
                          builder: (context) => DefaultButton(
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  shoplogincubit.get(context).Userlogin(
                                      password: passcontroller.text,
                                      email: emailcontroller.text);
                                }
                                print(
                                    '${state}+noooooooooooooooooooooowwwwwwwwwwwwww');
                                print(
                                    '${emailcontroller.toString()}+12312132654564687987');
                                print(passcontroller);
                              },
                              backroundcolor: Colors.blueAccent,
                              text: 'Login'),
                          fallback: (context) => CircularProgressIndicator(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(
                                      context: context,
                                      widget: RegisterScreen());
                                },
                                child: Text('Register ',
                                    style: TextStyle(fontSize: 18))),
                            Spacer(),
                            // TextButton(
                            //     onPressed: () {
                            //       cachehelper.Removedata('onboarding');
                            //     },
                            // child: Text('Register ',
                            //     style: TextStyle(fontSize: 18)))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
