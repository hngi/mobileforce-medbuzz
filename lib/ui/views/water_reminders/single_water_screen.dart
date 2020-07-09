import 'package:MedBuzz/core/models/water_reminder_model/water_reminder.dart';
import 'package:MedBuzz/ui/widget/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/core/database/waterReminderData.dart';
import 'package:MedBuzz/ui/navigation/app_navigation/app_transition.dart';

import '../../../core/notifications/water_notification_manager.dart';

class SingleWater extends StatefulWidget {
  SingleWater({this.water});

  final WaterReminder water;

  @override
  _SingleWaterState createState() => _SingleWaterState();
}

class _SingleWaterState extends State<SingleWater> {
  WaterReminder waterReminder;
  WaterNotificationManager waterNotificationManager =
      WaterNotificationManager();

  Navigation navigation = Navigation();

  final db = WaterReminderData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        elevation: 2.0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: ListView(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: Config.yMargin(context, 1)),
                child: FlatButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: DeleteDialog(),
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    label: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    )),
              ),
              //SizedBox(height: Config.yMargin(context, 3)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Config.xMargin(context, 5.33)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: Config.xMargin(context, 44),
                      child: Text(
                        'Drink ml of water',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: Config.textSize(context, 5.3),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(right: Config.xMargin(context, 5)),
                      child: Image.asset('images/waterdrop.png'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Config.yMargin(context, 3)),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: Config.xMargin(context, 5.33),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Description',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: Config.textSize(context, 4.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: Config.yMargin(context, 1.0)),
                        child: Text(
                          'A quick run from home to the estate junction and back home',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.textSize(context, 4),
                          ),
                          //\n
                        ),
                      ),
                      SizedBox(height: Config.yMargin(context, 10)),
                      Text(
                        'Frequency',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: Config.textSize(context, 4.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: Config.yMargin(context, 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Once Daily',
                              style: TextStyle(
                                fontSize: Config.textSize(context, 4),
                              ),
                            ),
                            Text(
                              "10:00AM",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: Config.textSize(context, 3.6),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: Config.yMargin(context, 10)),
                      Text(
                        'Length',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: Config.textSize(context, 4.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: Config.yMargin(context, 1.0)),
                        child: Text(
                          '4 days left out of 30 days',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.textSize(context, 4),
                          ),
                        ),
                      ),
                    ]),
              ),
              SizedBox(height: Config.yMargin(context, 10)),

              Padding(
                padding: EdgeInsets.only(bottom: Config.yMargin(context, 2.0)),
                child: Container(
                  padding: EdgeInsets.all(Config.xMargin(context, 3.55)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Config.yMargin(context, 1.28))),
                    color: Theme.of(context).primaryColor,
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: Config.xMargin(context, 5.33),
                      right: Config.xMargin(context, 6)), //24,24,27
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.bold,
                      fontSize: Config.textSize(context, 4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

void showSnackBar(BuildContext context) {
  SnackBar snackBar = SnackBar(
    backgroundColor: Theme.of(context).buttonColor.withOpacity(.9),
    duration: Duration(seconds: 2),
    content: Text(
      'Schedule deleted',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: Config.textSize(context, 5.3),
          color: Theme.of(context).primaryColorLight),
    ),
  );

  Scaffold.of(context).showSnackBar(snackBar);
}
