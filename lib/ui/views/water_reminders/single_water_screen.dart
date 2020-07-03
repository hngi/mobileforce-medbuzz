import 'package:MedBuzz/core/models/water_reminder_model/water_reminder.dart';
import 'package:MedBuzz/ui/notifications/water_notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/core/database/waterReminderData.dart';

class SingleWater extends StatelessWidget {
  SingleWater({this.waterReminder});
  final WaterReminder waterReminder;

  final WaterNotificationManager waterNotificationManager =
      WaterNotificationManager();
  final WaterReminderData waterReminderData = WaterReminderData();
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
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                height: Config.yMargin(context, 30),
                                width: Config.xMargin(context, 150.0),
                                //width: Config.xMargin(context, 50),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      Config.xMargin(context, 3.0)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Config.yMargin(context, 2),
                                            bottom: Config.yMargin(context, 1)),
                                        child: Text(
                                          'Are you sure you want to delete this?',
                                          style: TextStyle(
                                            fontSize:
                                                Config.textSize(context, 4.5),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height:
                                                Config.yMargin(context, 6.0),
                                            width:
                                                Config.xMargin(context, 30.0),
                                            child: RaisedButton(
                                              onPressed: () async {
                                                //Navigate to the Water reminder screen and delete from db

                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Config.textSize(
                                                      context, 5),
                                                ),
                                              ),
                                              color: Color(0xFF219653),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Config.xMargin(
                                                              context, 2.0))),
                                            ),
                                          ),
                                          Container(
                                            height:
                                                Config.yMargin(context, 6.0),
                                            width:
                                                Config.xMargin(context, 30.0),
                                            child: RaisedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Config.textSize(
                                                      context, 5),
                                                ),
                                              ),
                                              color: Color(0xFFEB5757),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Config.xMargin(
                                                              context, 2.0))),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
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
                        'Drink 250ml of Water',
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: Config.textSize(context, 7),
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
                          color: Color(0xff333333),
                          fontSize: Config.textSize(context, 5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: Config.yMargin(context, 1.0)),
                        child: Text(
                          'A quick run from home to the estate junction and back home',
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: Config.textSize(context, 4),
                          ),
                          //\n
                        ),
                      ),
                      SizedBox(height: Config.yMargin(context, 10)),
                      Text(
                        'Frequency',
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: Config.textSize(context, 5),
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
                              '8:00AM',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: Config.textSize(context, 4),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: Config.yMargin(context, 10)),
                      Text(
                        'Length',
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: Config.textSize(context, 5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: Config.yMargin(context, 1.0)),
                        child: Text(
                          '4 days left out of 30 days',
                          style: TextStyle(
                            color: Color(0xff333333),
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
                      fontSize: Config.textSize(context, 3.9),
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
