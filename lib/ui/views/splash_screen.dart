import 'dart:async';
//import 'package:MedBuzz/ui/views/Home.dart';
import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/user_db.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../core/constants/route_names.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  void open() async {
    await Hive.openBox('onboarding');
  }

  @override
  void initState() {
    super.initState();
    Provider.of<UserCrud>(context, listen: false).getuser();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, () {
      box.get('status') == 'true'
          ? Navigator.pushReplacementNamed(context, RouteNames.homePage)
          : Navigator.pushReplacementNamed(context, RouteNames.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }
  // route() {
  //   Navigator.pushReplacementNamed(context, RouteNames.onboarding);
  // }

  var box = Hive.box('onboarding');

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
