import 'package:ecommers/shared/component/components.dart';
import 'package:ecommers/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ecommers/modules/Shop-app/login/shop-login-screen.dart';

var boardcontroller = PageController();
bool islast = false;

class boardingmodel {
  final String? image;
  final String? title;
  final String? body;
  boardingmodel({this.image, this.body, this.title});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<boardingmodel> boarding = [
    boardingmodel(
        image: 'assets/images/onboardpic1.webp',
        title: ' Welcome',
        body: 'welcome in your shop'),
    boardingmodel(
        image: 'assets/images/onboardpic3.png',
        title: 'Online Shop',
        body: 'You Can Buy Whatever You Want in Your Home'),
    boardingmodel(
        image: 'assets/images/onboardpic5.png',
        title: 'Hello',
        body: 'Now Please Login ')
  ];
  void submit() {
    print('onvoardingscreeen');
    cachehelper.Savedata(key: 'onboarding', value: true).then((value) {
      if (value) {
        navigatoandremove(context: context, widget: Shoplogin());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
              child: Text(
                'SKIP',
              ),
              onPressed: () {
                submit();
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardcontroller,
                  itemBuilder: ((context, index) =>
                      buildboarding(boarding[index])),
                  itemCount: boarding.length,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      print('last');
                      setState(() {
                        islast = true;
                      });
                    } else {
                      setState(() {
                        islast = false;
                      });
                      print('not last');
                    }
                  },
                ),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardcontroller,
                      count: boarding.length,
                      effect: ExpandingDotsEffect(
                          offset: 19,
                          expansionFactor: 4,
                          activeDotColor: Colors.orange,
                          dotColor: Colors.amber.shade300)),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: Colors.orange,
                    elevation: 0,
                    onPressed: () async {
                      if (islast == true) {
                        submit();
                      } else {
                        boardcontroller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

Widget buildboarding(boardingmodel model) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                model.image.toString(),
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
            '${model.title.toString()}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${model.body.toString()}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ]);
