import 'dart:ui';

import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BadgesScreen extends StatefulWidget {
  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Badge',
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              StatBadge(),
              FitnessBadge(),
              WaterBadge(),
              DietBadge(),
              MedicationBadge()
            ],
          ),
        ),
      ),
    );
  }
}

class StatBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          padding: EdgeInsets.all(10),
          height: Config.yMargin(context, 19.7),
          width: Config.xMargin(context, 79),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).primaryColor),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Good Job Julia!',
                        style: TextStyle(
                            fontSize: Config.textSize(context, 5.09),
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColorLight)),
                    Text(
                      'You have logged your \nstats successfully everyday \nin the last 7 days!',
                      style: TextStyle(
                          fontSize: Config.textSize(context, 2.56),
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).primaryColorLight),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: Image.asset(
                        'images/weekdaychart.png',
//                          height: 50,
                      ),
                    ),
                    SizedBox(
                      height: Config.yMargin(context, 1.32),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          'stats for the week',
                          style: TextStyle(
                              fontSize: Config.textSize(context, 2.04),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).primaryColorLight),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class FitnessBadge extends StatefulWidget {
  final String badgeImage;
  final String badgeName;
  final int hours;
  final double height;
  final double width;

  FitnessBadge(
      {this.badgeImage, this.badgeName, this.hours, this.height, this.width});

  @override
  _FitnessBadgeState createState() => _FitnessBadgeState();
}

class _FitnessBadgeState extends State<FitnessBadge> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          height: Config.yMargin(context, 19.7),
          width: Config.xMargin(context, 79),
          decoration: BoxDecoration(
//              boxShadow: [
//                BoxShadow(
//                  color: Color(0xffE4E4E4),
//                  spreadRadius: 5,
//                  offset: Offset(0, 1),
//                ),
//              ],
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).primaryColorLight),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: Config.yMargin(context, 7.90),
                      width: Config.xMargin(context, 12.72),
                      child: Image.asset('images/fitnessbadge-active.png'),
                    ),
                    Container(
//                    padding: EdgeInsets.only(bottom: 10),
                      height: Config.yMargin(context, 5.27),
                      child: VerticalDivider(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Fitness',
                          style: TextStyle(
                              fontSize: Config.textSize(context, 4.07),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Completed',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '6:30 AM',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 2.6),
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              width: Config.xMargin(context, 2.04),
                            ),
                            Text(
                              '19th July, 2020',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 2.6),
                                  color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 22.14),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.share,
                                color: Colors.blue.shade700,
                                size: 35,
                              ),
                              onPressed: () {}),
                        ),
                        Text(
                          'Share',
                          style: TextStyle(
                              fontSize: Config.textSize(context, 2.6),
                              color: Colors.blue.shade700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Accept Badge',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 3.56),
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      SizedBox(
                        width: Config.textSize(context, 25.45),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: Config.xMargin(context, 2.6),
                              ),
                              Text('Done',
                                  style: TextStyle(
                                      fontSize: Config.textSize(context, 3.56),
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WaterBadge extends StatefulWidget {
  final String badgeImage;
  final String badgeName;
  final int hours;
  final double height;
  final double width;

  WaterBadge(
      {this.badgeImage, this.badgeName, this.hours, this.height, this.width});

  @override
  _WaterBadgeState createState() => _WaterBadgeState();
}

class _WaterBadgeState extends State<WaterBadge> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          height: Config.yMargin(context, 19.7),
          width: Config.xMargin(context, 79),
          decoration: BoxDecoration(
//              boxShadow: [
//                BoxShadow(
//                  color: Color(0xffE4E4E4),
//                  spreadRadius: 5,
//                  offset: Offset(0, 1),
//                ),
//              ],
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).primaryColorLight),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: Config.yMargin(context, 7.90),
                      width: Config.xMargin(context, 12.72),
                      child: Image.asset('images/waterbadge-inactive.png'),
                    ),
                    Container(
//                    padding: EdgeInsets.only(bottom: 10),
                      height: Config.yMargin(context, 5.27),
                      child: VerticalDivider(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Water Tracker',
                          style: TextStyle(
                              fontSize: Config.textSize(context, 4.07),
                              fontWeight: FontWeight.bold),
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'Total Points Earned: ',
                                style: TextStyle(color: Colors.grey),
                                children: [
                              TextSpan(
                                  text: '25 / 50',
                                  style: TextStyle(color: Colors.blue.shade900))
                            ])),
                        Row(
                          children: <Widget>[
                            Text(
                              '6:30 AM',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 2.6),
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              width: Config.xMargin(context, 2.04),
                            ),
                            Text(
                              '19th July, 2020',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 2.6),
                                  color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 6.14),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.share,
                                color: Colors.blue.shade700,
                                size: 35,
                              ),
                              onPressed: () {}),
                        ),
                        Text(
                          'Share',
                          style: TextStyle(
                              fontSize: Config.textSize(context, 2.6),
                              color: Colors.blue.shade700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 35),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: Config.xMargin(context, 2.6),
                              ),
                              Text('Skip',
                                  style: TextStyle(
                                      fontSize: Config.textSize(context, 3.56),
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Config.textSize(context, 25.45),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: Config.xMargin(context, 2.6),
                              ),
                              Text('Done',
                                  style: TextStyle(
                                      fontSize: Config.textSize(context, 3.56),
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DietBadge extends StatefulWidget {
  final String badgeImage;
  final String badgeName;
  final int hours;
  final double height;
  final double width;

  DietBadge(
      {this.badgeImage, this.badgeName, this.hours, this.height, this.width});

  @override
  _DietBadgeState createState() => _DietBadgeState();
}

class _DietBadgeState extends State<DietBadge> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          height: Config.yMargin(context, 19.7),
          width: Config.xMargin(context, 79),
          decoration: BoxDecoration(
//              boxShadow: [
//                BoxShadow(
//                  color: Color(0xffE4E4E4),
//                  spreadRadius: 5,
//                  offset: Offset(0, 1),
//                ),
//              ],
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).primaryColorLight),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: Config.yMargin(context, 7.90),
                      width: Config.xMargin(context, 12.72),
                      child: Image.asset('images/dietbadge-active.png'),
                    ),
                    Container(
//                    padding: EdgeInsets.only(bottom: 10),
                      height: Config.yMargin(context, 5.27),
                      child: VerticalDivider(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Diet',
                          style: TextStyle(
                              fontSize: Config.textSize(context, 4.07),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Completed',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '6:30 AM',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 2.6),
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              width: Config.xMargin(context, 2.04),
                            ),
                            Text(
                              '19th July, 2020',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 2.6),
                                  color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 22.14),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.share,
                                color: Colors.blue.shade700,
                                size: 35,
                              ),
                              onPressed: () {}),
                        ),
                        Text(
                          'Share',
                          style: TextStyle(
                              fontSize: Config.textSize(context, 2.6),
                              color: Colors.blue.shade700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Accept Badge',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 3.56),
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      SizedBox(
                        width: Config.textSize(context, 25.45),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: Config.xMargin(context, 2.6),
                              ),
                              Text('Done',
                                  style: TextStyle(
                                      fontSize: Config.textSize(context, 3.56),
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MedicationBadge extends StatefulWidget {
  final String badgeImage;
  final String badgeName;
  final int hours;
  final double height;
  final double width;

  MedicationBadge(
      {this.badgeImage, this.badgeName, this.hours, this.height, this.width});

  @override
  _MedicationBadgeState createState() => _MedicationBadgeState();
}

class _MedicationBadgeState extends State<MedicationBadge> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          height: Config.yMargin(context, 19.7),
          width: Config.xMargin(context, 79),
          decoration: BoxDecoration(
//              boxShadow: [
//                BoxShadow(
//                  color: Color(0xffE4E4E4),
//                  spreadRadius: 5,
//                  offset: Offset(0, 1),
//                ),
//              ],
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).primaryColorLight),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: Config.yMargin(context, 7.90),
                      width: Config.xMargin(context, 12.72),
                      child: Image.asset('images/medicationbadge-inactive.png'),
                    ),
                    Container(
//                    padding: EdgeInsets.only(bottom: 10),
                      height: Config.yMargin(context, 5.27),
                      child: VerticalDivider(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Medication',
                          style: TextStyle(
                              fontSize: Config.textSize(context, 4.07),
                              fontWeight: FontWeight.bold),
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'Total Points Earned: ',
                                style: TextStyle(color: Colors.grey),
                                children: [
                              TextSpan(
                                  text: '25 / 50',
                                  style: TextStyle(color: Colors.blue.shade900))
                            ])),
                        Row(
                          children: <Widget>[
                            Text(
                              '6:30 AM',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 2.6),
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              width: Config.xMargin(context, 2.04),
                            ),
                            Text(
                              '19th July, 2020',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 2.6),
                                  color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 6.14),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.share,
                                color: Colors.blue.shade700,
                                size: 35,
                              ),
                              onPressed: () {}),
                        ),
                        Text(
                          'Share',
                          style: TextStyle(
                              fontSize: Config.textSize(context, 2.6),
                              color: Colors.blue.shade700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 35),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: Config.xMargin(context, 2.6),
                              ),
                              Text('Skip',
                                  style: TextStyle(
                                      fontSize: Config.textSize(context, 3.56),
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Config.textSize(context, 25.45),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: Config.xMargin(context, 2.6),
                              ),
                              Text('Done',
                                  style: TextStyle(
                                      fontSize: Config.textSize(context, 3.56),
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
