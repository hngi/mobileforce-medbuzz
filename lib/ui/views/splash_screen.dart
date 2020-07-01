import 'dart:async';
//import 'package:MedBuzz/ui/views/Home.dart';
import 'package:MedBuzz/ui/views/home_page.dart';
import 'package:MedBuzz/ui/views/onboarding.dart';
import 'package:flutter/material.dart';




class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Onboard()));

  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('images/MedBuzz.png'),
            ),
          ],
        ),
      ),
    );
  }
}
