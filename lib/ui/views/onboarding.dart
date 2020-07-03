import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'package:MedBuzz/ui/navigation/page_transition/page_transition.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/widget/dot_indicator.dart';
import 'package:flutter/material.dart';

class Onboard extends StatefulWidget {
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  PageController _controller;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(Config.yMargin(context, 1));
    print(Config.xMargin(context, 1));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appThemeLight.primaryColorLight,
        actions: <Widget>[
          Container(
            padding: const EdgeInsetsDirectional.only(top: 30),
            child: FlatButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'signup');
              }, //navigate to the sign up page
              child: Text(
                "Skip",
                style: TextStyle(
                    color: appThemeLight.primaryColorDark,
                    fontSize: Config.textSize(context, 3.7),
                    fontWeight: FontWeight.normal),
              ),
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            PageView(
              onPageChanged: onChangedFunction,
              controller: _controller,
              children: <Widget>[
                FirstScreen(
                  image: 'images/schedule.png',
                  description: 'Book appointments with \ndoctors',
                ),
                FirstScreen(
                  image: 'images/doctor.png',
                  description:
                      'Keep track of your medications \nand set reminders for them',
                ),
                FirstScreen(
                  image: 'images/habit.png',
                  description: 'Monitor your health activities',
                )
              ],
            ),
            Positioned(
              bottom: Config.yMargin(context, 21.0),
              left: Config.xMargin(context, 41.6),
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Indicator(
                      positionIndex: 0,
                      currentIndex: currentIndex,
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 2.63),
                    ),
                    Indicator(
                      positionIndex: 1,
                      currentIndex: currentIndex,
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 2.63),
                    ),
                    Indicator(
                      positionIndex: 2,
                      currentIndex: currentIndex,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: Config.yMargin(context, 8.7),
              left: Config.xMargin(context, 14),
              child: Container(
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: Config.yMargin(context, 6),
                      width: Config.xMargin(context, 27),
                      decoration: BoxDecoration(
                          color: appThemeLight.primaryColor,
                          border: Border.all(color: appThemeLight.primaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'signup');
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: appThemeLight.primaryColorLight,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 17),
                    ),
                    Container(
                      height: Config.yMargin(context, 6),
                      width: Config.xMargin(context, 27),
                      decoration: BoxDecoration(
                          color: appThemeLight.primaryColorLight,
                          border: Border.all(color: appThemeLight.primaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'login');
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: appThemeLight.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

// class to display the screens
class FirstScreen extends StatelessWidget {
  final Config config = Config();
  final image;
  final description;

  FirstScreen({this.image, this.description});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appThemeLight.primaryColorLight,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Config.xMargin(context, 6),
            vertical: Config.yMargin(context, 5)),
        child: Container(
          height: height,
          width: width,
          child: Column(
            children: <Widget>[
              Container(
                height: height * .45,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.contain)),
              ),
              SizedBox(height: Config.yMargin(context, 3.4)),
              Container(
                child: ForwardAnimation(
                  milliseconds: 500,
                  child: Text(description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: Config.textSize(context, 3.7),
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
