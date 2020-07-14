import 'package:MedBuzz/core/database/water_taken_data.dart';
import 'package:MedBuzz/ui/views/water_reminders/schedule_water_reminder_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../size_config/config.dart';
import 'schedule_water_reminder_screen.dart';
import '../../../core/constants/route_names.dart';
import '../../../core/database/waterReminderData.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:MedBuzz/ui/widget/water_reminder_card.dart';
import 'package:MedBuzz/ui/navigation/app_navigation/app_transition.dart';

//IF YOU TOUCH ANYTHING IN THIS SCREEN, THUNDER WILL FIRE YOU
//I'm going to touch it small Sir, sorry
class WaterScheduleViewScreen extends StatelessWidget {
  final Navigation navigation = Navigation();
  final String payload;
  WaterScheduleViewScreen({this.payload});

//IF YOU TOUCH ANYTHING IN THIS SCREEN, THUNDER WILL FIRE YOU
  @override
  Widget build(BuildContext context) {
    // var waterReminder =
    //     Provider.of<ScheduleWaterReminderViewModel>(context, listen: true);
    var waterReminderDB = Provider.of<WaterReminderData>(context, listen: true);
    waterReminderDB.getWaterReminders();
    var waterReminder =
        Provider.of<ScheduleWaterReminderViewModel>(context, listen: true);

    var waterTakenDB = Provider.of<WaterTakenData>(context, listen: true);
    waterTakenDB.getWaterTaken();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
//IF YOU TOUCH ANYTHING IN THIS SCREEN, THUNDER WILL FIRE YOU

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Visibility(
            visible: waterReminderDB.waterRemindersCount > 0,
            child: Container(
              margin: EdgeInsets.only(
                  bottom: Config.yMargin(context, 2),
                  right: Config.xMargin(context, 4)),
              child: SizedBox(
//IF YOU TOUCH ANYTHING IN THIS SCREEN, THUNDER WILL FIRE YOU
                height: height * 0.07,
                width: height * 0.07,
                child: FloatingActionButton(
                  heroTag: 'edit',
                  elevation: 0,
                  onPressed: () {
                    print('hi');
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.edit,
                    size: Config.textSize(context, 7),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: Config.yMargin(context, 2),
                right: Config.xMargin(context, 4)),
            child: SizedBox(
//IF YOU TOUCH ANYTHING IN THIS SCREEN, THUNDER WILL FIRE YOU
              height: height * 0.07,
              width: height * 0.07,
              child: FloatingActionButton(
                heroTag: 'add/drink',
                elevation: 0,
                onPressed: () {
                  waterReminderDB.waterRemindersCount == 0
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ScheduleWaterReminderScreen()))
                      : waterTakenDB.addWaterTaken(
                          waterReminderDB.waterReminders[0].ml, DateTime.now());
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  waterReminderDB.waterRemindersCount == 0
                      ? Icons.add
                      : Icons.local_drink,
                  size: Config.textSize(context, 7),
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Water Reminders',
            style: TextStyle(color: Theme.of(context).primaryColorDark)),
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace,
                color: Theme.of(context).primaryColorDark),

            //Function to navigate to previous screen or home screen (as the case maybe) goes here
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.homePage);
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: SingleChildScrollView(
            //container wrapping all the widgets
            child: Container(
              margin: EdgeInsets.only(
                  right: Config.xMargin(context, 7),
                  left: Config.xMargin(context, 7),
                  top: Config.yMargin(context, 5),
                  bottom: Config.yMargin(context, 10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: SizedBox(
//IF YOU TOUCH ANYTHING IN THIS SCREEN, THUNDER WILL FIRE YOU
                            height: height * 0.37,
                            width: height * 0.37,
                            child: CircularProgressIndicator(
                                backgroundColor: Color(0xffE5E5E5),
                                valueColor: AlwaysStoppedAnimation(
                                    Theme.of(context)
                                        .primaryColor
                                        .withOpacity(waterTakenDB.progress)),
                                value: waterTakenDB.progress,
                                strokeWidth: width * 0.04),
                          ),
                        ),
                        Center(
                          child: Container(
                            //takes same height as sizedbox of progress indicator so that it can align to the center of that height
                            height: height * 0.37,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: AssetImage('images/waterdrop.png'),
                                ),
                                SizedBox(height: Config.yMargin(context, 7)),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '${waterTakenDB.currentLevel} ' + 'ml',
                                      style: TextStyle(
                                          fontSize: Config.textSize(context, 7),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Config.yMargin(context, 0.7)),
                                Text(
                                  'of ${waterTakenDB.totalLevel} ml',
                                  style: TextStyle(
                                      fontSize: Config.textSize(context, 4.5),
                                      color:
                                          Theme.of(context).primaryColorDark),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Config.yMargin(context, 5)),
                  Visibility(
                      visible: waterReminderDB.waterReminders.isEmpty,
                      child: Container(
                        child: Text('No water reminders'),
                      )),
                  Visibility(
                      visible: waterReminderDB.waterReminders.isNotEmpty,
                      child: Container(
                        child: Text(
                            '${DateFormat.yMMMEd().format((DateTime.now()))}'),
                      )),
                  for (var waterReminder
                      in waterReminderDB.getActiveReminders())
                    WaterReminderCard(
                        height: height,
                        width: width,
                        waterReminder: waterReminder),
                  SizedBox(height: Config.yMargin(context, 5)),
                  Text('Water Log'),
                  SizedBox(height: Config.yMargin(context, 0)),
                  Column(
                    children: waterTakenDB.waterTaken
                        .map((ml) => GestureDetector(
                              onTap: () =>
                                  waterReminder.updateSelectedMl(ml.ml),
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: Config.yMargin(context, 1.5)),
                                padding: EdgeInsets.symmetric(
                                  vertical: Config.yMargin(context, 2),
                                  horizontal: Config.yMargin(context, 3),
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.03),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius:
                                      BorderRadius.circular(width * 0.03),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    // Text(
                                    //   '${ml.ml}' + 'ml',
                                    //   style: waterReminder.gridItemTextStyle(
                                    //       context, ml.ml),
                                    // ),
                                    // SizedBox(height: height * 0.01),
                                    Text(
                                        // DateFormat.jm()
                                        //     .format(ml.dateTime)
                                        //     .toString(),
                                        ml.dateTime.toString(),
                                        style: waterReminder
                                            .gridItemTextStyle(context, ml.ml)
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColorDark
                                                    .withOpacity(0.7))),
                                    GestureDetector(
                                        child: Icon(
                                          Icons.delete,
                                          color: Theme.of(context)
                                              .primaryColorDark
                                              .withOpacity(0.7),
                                          size: waterReminder
                                              .gridItemTextStyle(context, ml.ml)
                                              .fontSize,
                                        ),
                                        onTap: () async {
                                          // print('del');
                                          await waterTakenDB
                                              .deleteWaterTaken(
                                                  ml.dateTime.toString())
                                              .then((value) =>
                                                  waterTakenDB.getWaterTaken());
                                        })
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: Config.yMargin(context, 20)),

                  // Container(
                  //   height: height * 0.8,
                  //   child: GridView.count(
                  //     primary: true,
                  //     // padding: EdgeInsets.symmetric(
                  //     //     horizontal: Config.xMargin(context, 7),
                  //     //     vertical: Config.yMargin(context, 2)),
                  //     crossAxisSpacing: 10,
                  //     mainAxisSpacing: 10,
                  //     crossAxisCount: 3,
                  //     children: waterTakenDB.waterTaken.map((ml) {
                  //       return ;
                  //     }).toList(),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
