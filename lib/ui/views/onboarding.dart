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
    _controller = PageController(
      initialPage: 0,
      keepPage: false,
    );
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
        child: Column(
          children: <Widget>[
            Container(
              height: height * .73,
              width: width,
              child: PageView(
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
            ),
            Container(
              height: height * .07,
              margin: EdgeInsets.only(top: Config.yMargin(context, 1)),
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
            Container(
              margin: EdgeInsets.only(top: Config.yMargin(context, 4.5)),
              height: Config.yMargin(context, 6),
              width: Config.xMargin(context, 40),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius:
                      BorderRadius.circular(Config.xMargin(context, 2.77))),
              child: FlatButton(
                onPressed: () {
                  currentIndex == 2
                      ? Navigator.pushReplacementNamed(context, 'signup')
                      : _controller.animateToPage(++currentIndex,
                          duration: Duration(milliseconds: 150),
                          curve: Curves.easeInOutQuad);
                },
                splashColor: Theme.of(context).primaryColor,
                child: Text(
                  currentIndex == 2 ? 'Get started' : "Next",
                  style: TextStyle(
                      fontSize: Config.textSize(context, 3.85),
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.bold),
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
  final String image;
  final String description;

  FirstScreen({this.image, this.description});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Config.xMargin(context, 6),
            vertical: Config.yMargin(context, 5)),
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
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
                height: height * .38,
                width: width,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.contain)),
              ),
              SizedBox(height: Config.yMargin(context, 3)),
              Container(
                color: Theme.of(context).backgroundColor,
                child: ForwardAnimation(
                  milliseconds: 500,
                  child: Text(description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: Config.textSize(context, 6),
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
