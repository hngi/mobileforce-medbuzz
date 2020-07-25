import 'dart:ui';

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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[FitnessBadge()],
        ),
      ),
    ));
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
          height: 150,
          width: 311,
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
                      height: 60,
                      width: 50,
                      child: Image.asset('images/fitnessbadge-active.png'),
                    ),
                    Container(
//                    padding: EdgeInsets.only(bottom: 10),
                      height: 40,
                      child: VerticalDivider(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Fitness',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Completed',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '6:30 AM',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '19th July, 2020',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.share,
                                color: Colors.blue.shade700,
                                size: 30,
                              ),
                              onPressed: () {}),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Text('Accept Badge',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      SizedBox(
                        width: 130,
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
                                width: 10,
                              ),
                              Text('Done',
                                  style: TextStyle(
                                      fontSize: 14,
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
