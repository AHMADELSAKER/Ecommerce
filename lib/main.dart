import 'package:ecommers/layout/Shop/Cubit/Cubit.dart';
import 'package:ecommers/modules/Shop-app/onboarding/onboarding.dart';
import 'package:ecommers/shared/bloc_observe.dart';
import 'package:ecommers/shared/network/local/cache_helper.dart';
import 'package:ecommers/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
// import 'package:ecommers/modules/Shop-app/onboarding/onboarding.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shared/component/Constants.dart';
import 'layout/Shop/Shop_layout.dart';
import 'modules/Shop-app/login/shop-login-screen.dart';
import 'package:ecommers/modules/Shop-app/onboarding/onboarding.dart';

void main() async {
  // ليتاكد انو كل الويدجت خلصت بعدين بكمل شغل
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  DioHelper.init();
  await cachehelper.init();
  Widget? widgt;
  dynamic onboarding = cachehelper.getdata(key: 'onboarding') ?? null;
  token = cachehelper.getdata(key: 'token');
  // Print(onboarding);
  if (onboarding != null) {
    if (token != null)
      widgt = Shop_layout_screen();
    else
      widgt = Shoplogin();
  } else {
    widgt = OnBoardingScreen();
  }

  runApp(MyApp(
    Startwidget: widgt,
  ));
}

/// Custom [BlocObserver] that observes all bloc and cubit state changes.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

/// Custom [BlocObserver] that observes all bloc and cubit state changes.

class MyApp extends StatelessWidget {
  Widget? Startwidget;
  MyApp({this.Startwidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopHomeCubit()
              ..GetHomeData()
              ..GetCategoriesData()
              ..GetFaveItem()
              ..GetUserData())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        // themeMode: ThemeMode.dark,
        // darkTheme: ThemeData(
        //   brightness: Brightness.dark,
        //   primarySwatch: Colors.blueGrey,
        //   canvasColor: Color.fromRGBO(52, 58, 70, 1),
        //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
        //     selectedIconTheme: IconThemeData(
        //       color: Colors.pink,
        //       size: 28,
        //     ),
        //     unselectedIconTheme: IconThemeData(
        //       color: Color.fromRGBO(196, 201, 212, 1),
        //       size: 28,
        //     ),
        //   ),
        // ),
        home: Startwidget,
      ),
    );
  }
}
