import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'package:MedBuzz/ui/navigation/page_transition/page_transition.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/widget/dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
    return Scaffold(
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
              left: Config.xMargin(context, 37),
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: Config.yMargin(context, 6),
                        width: Config.xMargin(context, 27),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, 'signup');
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: Config.xMargin(context, 17),
                    // ),
                    // Container(
                    //   height: Config.yMargin(context, 6),
                    //   width: Config.xMargin(context, 27),
                    //   decoration: BoxDecoration(
                    //       color: Theme.of(context).primaryColorLight,
                    //       border:
                    //           Border.all(color: Theme.of(context).primaryColor),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: FlatButton(
                    //     onPressed: () {
                    //       box.put('status', 'true');
                    //       Navigator.pushReplacementNamed(
                    //           context, RouteNames.login);
                    //     },
                    //     child: Text(
                    //       "Login",
                    //       style: TextStyle(
                    //           color: Theme.of(context).primaryColor,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),
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
  final image;
  final description;

  FirstScreen({this.image, this.description});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var box = Hive.box('onboarding');
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Config.xMargin(context, 6),
            vertical: Config.yMargin(context, 5)),
        child: Container(
          height: height,
          width: width,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      
                      Navigator.pushReplacementNamed(
                          context, RouteNames.signup);
                    }, //navigate to the sign up page
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: Config.textSize(context, 4.5),
                          fontWeight: FontWeight.normal),
                    ),
                    color: Colors.transparent,
                  ),
                ],
              ),
              Container(
                height: height * .4,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.contain)),
              ),
              SizedBox(height: Config.yMargin(context, 3)),
              Container(
                child: ForwardAnimation(
                  milliseconds: 500,
                  child: Text(description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: Config.textSize(context, 6.5),
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
