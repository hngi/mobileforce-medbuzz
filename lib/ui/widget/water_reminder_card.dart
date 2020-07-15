import 'package:MedBuzz/core/database/waterReminderData.dart';
import 'package:MedBuzz/core/database/water_taken_data.dart';
import 'package:MedBuzz/core/notifications/water_notification_manager.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/water_reminders/single_water_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/models/water_reminder_model/water_reminder.dart';
import 'package:MedBuzz/ui/views/water_reminders/schedule_water_reminder_model.dart';

class WaterReminderCard extends StatefulWidget {
  final double height;
  final double width;
  final WaterReminder waterReminder;

  final ScheduleWaterReminderViewModel scheduleWaterReminderViewModel =
      ScheduleWaterReminderViewModel();

  WaterReminderCard(
      {@required this.height,
      @required this.width,
      @required this.waterReminder});
  @override
  _WaterCardState createState() => _WaterCardState();
}

class _WaterCardState extends State<WaterReminderCard> {
  bool isSelected = false;

  String _status(waterReminder, progress) {
    String value = 'Ongoing';
    if (DateTime.now().difference(waterReminder.startTime).inDays == 0 &&
        progress >= 1) {
      value = 'Completed';
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var waterTakenDB = Provider.of<WaterTakenData>(context, listen: true);
    // var waterReminder =
    //     Provider.of<ScheduleWaterReminderViewModel>(context, listen: true);
    // WaterNotificationManager waterNotificationManager =
    //     WaterNotificationManager();
    return Container(
      width: double.infinity,
      child: GestureDetector(
        //Navigate to screen with single reminder i.e the on user clicked on
        onTap: () {
          // setState(() => isSelected = !isSelected);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SingleWater(water: widget.waterReminder)));
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: widget.height * 0.02),
              Text(
                DateFormat.jm().format(widget.waterReminder.startTime) ??
                    "10:00 AM",
              ),
              SizedBox(height: widget.height * 0.02),
              Container(
                  width: widget.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.xMargin(context, 4),
                      vertical: Config.yMargin(context, 2)),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius:
                        BorderRadius.circular(Config.xMargin(context, 5)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              right: Config.xMargin(context, 7),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Image(
                                  image: AssetImage(
                                    'images/bigdrop.png',
                                  ),
                                  height: height * 0.05,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: width < height * 7
                                          ? Config.xMargin(context, 3.3)
                                          : Config.xMargin(context, 4.5),
                                      top: width < height * 7
                                          ? Config.yMargin(context, 0.8)
                                          : Config.yMargin(context, 1)),
                                  child: Image(
                                    image: AssetImage('images/smalldrop.png'),
                                    height: height * 0.03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Drink ${widget.waterReminder.ml ?? 0}ml of water',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: widget.height * 0.005),
                              Text(
                                _status(widget.waterReminder,
                                    waterTakenDB.progress),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            ],
                          ),

                          //Temporary fix to delete reminders

                          // Expanded(
                          //   child: Container(
                          //     margin: EdgeInsets.only(
                          //       left: Config.xMargin(context, 20),
                          //     ),
                          //     child: IconButton(
                          //       onPressed: () {
                          //         waterReminderDB.deleteWaterReminder(
                          //             widget.waterReminder.id);
                          //         waterNotificationManager.removeReminder(
                          //             waterReminder.selectedDay);
                          //       },
                          //       icon: Icon(Icons.delete),
                          //       color: Colors.red,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                      SizedBox(
                        height: Config.yMargin(context, 1),
                        width: double.infinity,
                      ),
                      Visibility(
                        visible: false,
                        child: Divider(
                          color: Theme.of(context).primaryColorDark,
                          height: widget.height * 0.02,
                          endIndent: 10.0,
                        ),
                      ),
                      // Visibility(
                      //     visible: isSelected,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       mainAxisSize: MainAxisSize.max,
                      //       children: <Widget>[
                      //         Expanded(child: flatButton('View')),
                      //         // Expanded(child: flatButton('Skip')),
                      //         // Expanded(child: flatButton('Reset'))
                      //       ],
                      //     ))
                    ],
                  )),
            ]),
      ),
    );
  }

  Widget flatButton(String text) {
    var waterReminderDB = Provider.of<WaterReminderData>(context, listen: true);
    return FlatButton(
      onPressed: () {
        switch (text) {
          case 'Skip':
            waterReminderDB.editWaterReminder(
                waterReminder: WaterReminder(
                    interval: widget.waterReminder.interval,
                    description: widget.waterReminder.description,
                    endTime: widget.waterReminder.endTime,
                    ml: widget.waterReminder.ml,
                    startTime: widget.waterReminder.startTime,
                    id: widget.waterReminder.id,
                    isSkipped: true,
                    isTaken: false),
                waterReminderKey: widget.waterReminder.id);
            break;
          case 'Done':
            waterReminderDB.editWaterReminder(
                waterReminder: WaterReminder(
                    interval: widget.waterReminder.interval,
                    description: widget.waterReminder.description,
                    endTime: widget.waterReminder.endTime,
                    ml: widget.waterReminder.ml,
                    startTime: widget.waterReminder.startTime,
                    id: widget.waterReminder.id,
                    isSkipped: false,
                    isTaken: true),
                waterReminderKey: widget.waterReminder.id);
            break;
          case 'View':
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SingleWater(water: widget.waterReminder)));
            break;
            // case 'Reset':
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               SingleWater(water: widget.waterReminder)));
            break;
          default:
        }

        // setState(() {
        //   text == 'Skip' ? waterRe = true : _skip = false;
        //   text == 'Done' ? _done = true : _done = false;
        // });
      },
      child: Row(
        children: <Widget>[
          Icon(
            text == 'Skip' ? Icons.close : text == 'Done' ? Icons.check : null,
            size: 15,
            color: Theme.of(context).primaryColorDark,
          ),
          SizedBox(
            width: Config.xMargin(context, 2),
          ),
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Config.textSize(context, 3.7),
                color: Theme.of(context).primaryColorDark),
          ),
        ],
      ),
    );
  }
}
