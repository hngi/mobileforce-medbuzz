import 'package:MedBuzz/core/notifications/healthtips_notification_manager.dart';
import 'package:MedBuzz/ui/views/home_screen/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:MedBuzz/ui/views/health_tips/health_tips_bank.dart';

class HealthTips extends StatefulWidget {
  HealthTips({this.payload});
  final String payload;
  @override
  _HealthTipsState createState() => _HealthTipsState();
}

class _HealthTipsState extends State<HealthTips> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  HealthTipsManager healthTipsManager = HealthTipsManager();

  HealthTipsBank healthTipsBank = HealthTipsBank();

  @override
  void initState() {
    super.initState();
    healthTipsManager.initNotifications();
    healthTipsManager.showNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SimpleDialog(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: Config.textSize(context, 7.8),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    healthTipsBank.getTipsTitle(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Config.textSize(context, 6),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                Text(
                  healthTipsBank.getTip(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Config.textSize(context, 4.85),
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(Config.xMargin(context, 5)),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: Config.xMargin(context, 5.3),
                vertical: Config.yMargin(context, 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
