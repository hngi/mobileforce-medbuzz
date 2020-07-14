import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/water_reminders/schedule_water_reminder_model.dart';
import 'package:MedBuzz/ui/widget/time_wheel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/database/waterReminderData.dart';
import '../../../core/notifications/water_notification_manager.dart';

class ScheduleWaterReminderScreen extends StatelessWidget {
  //values of water measures - stored as int in case of any need to calculate
  static const routeName = 'schedule-water-reminder';
  final ItemScrollController _scrollController = ItemScrollController();
  ScheduleWaterReminderScreen();
  final TextEditingController descriptionTextController =
      TextEditingController();
  final TextEditingController intervalTextController = TextEditingController();
  final TextEditingController mlTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var waterReminder =
        Provider.of<ScheduleWaterReminderViewModel>(context, listen: true);
    var waterReminderDB = Provider.of<WaterReminderData>(context, listen: true);
    waterReminderDB.getWaterReminders();
    WaterNotificationManager waterNotificationManager =
        WaterNotificationManager();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      waterReminder.updateAvailableReminders(waterReminderDB.waterReminders);
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Theme.of(context).primaryColorDark),
          title: Text(
            'Add a water reminder',
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: false, icon: Icon(Icons.expand_more),
                    // here sets the value to the selected month and if null, it defaults to the present date month from DateTime.now()
                    value: waterReminder.currentMonth,
                    hint: Text(
                      'Month',
                      textAlign: TextAlign.center,
                    ),
                    items: monthValues
                        .map((month) => DropdownMenuItem(
                              child: Container(
                                child: Text(
                                  month.month,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                ),
                              ),
                              value: month.month,
                            ))
                        .toList(),
                    onChanged: (val) => waterReminder.updateSelectedMonth(val),
                  ),
                ),
                Container(
                  //without specifying this height, flutter throws an error because of the grid
                  height: height * 0.15,
                  child: ScrollablePositionedList.builder(
                    //sets default selected day to the index of Date.now() date
                    initialScrollIndex: waterReminder.selectedDay - 1,
                    itemScrollController: _scrollController,
                    //dynamically sets the itemCount to the number of days in the currently selected month
                    itemCount: waterReminder.daysInMonth,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          waterReminder.updateSelectedDay(index);
                          _scrollController.scrollTo(
                            index: index,
                            duration: Duration(seconds: 1),
                          );
                        },
                        child: Container(
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            color: waterReminder.getButtonColor(context, index),
                            borderRadius: BorderRadius.circular(height * 0.04),
                          ),
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.only(left: Config.xMargin(context, 2)),
                          // padding: EdgeInsets.symmetric(
                          //     horizontal: Config.xMargin(context, 4.5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (index + 1).toString(),
                                style: waterReminder.calendarTextStyle(
                                    context, index),
                              ),
                              SizedBox(height: Config.yMargin(context, 1.5)),
                              Text(
                                waterReminder.getWeekDay(index),
                                style: waterReminder.calendarSubTextStyle(
                                    context, index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: Config.yMargin(context, 3)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Start Time'),
                      SizedBox(height: height * 0.01),
                      Container(
                        // this also acts like a negative margin to get rid of the excess space from moving the grid up
                        alignment: Alignment.topCenter,
                        child: Container(
                          // height: height * 0.15,
                          child: TimeWheel(
                            updateTimeChanged: (val) =>
                                waterReminder.updateSelectedStartTime(val),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: height * 0.01),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: Config.yMargin(context, 3)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('End Time'),
                      SizedBox(height: height * 0.01),
                      Container(
                        // this also acts like a negative margin to get rid of the excess space from moving the grid up
                        alignment: Alignment.topCenter,
                        child: Container(
                          // height: height * 0.15,
                          child: TimeWheel(
                            updateTimeChanged: (val) =>
                                waterReminder.updateSelectedEndTime(val),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Config.xMargin(context, 7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Time Interval',
                        style: TextStyle(
                            fontSize: Config.textSize(context, 5),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: Config.yMargin(context, 1.5)),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        initialValue:
                            waterReminder.selectedInterval?.toString() ?? '',
                        onChanged: (val) => waterReminder
                            .updateSelectedInterval(int.parse(val)),
                        // controller: intervalTextController,
                        cursorColor: Theme.of(context).primaryColorDark,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.xMargin(context, 5.5)),
                        decoration: InputDecoration(
                          hintText: 'Input intervals for reminder...',
                          hintStyle: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.xMargin(context, 5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Config.xMargin(context, 5))),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Config.xMargin(context, 5))),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.xMargin(context, 7)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Quantity of Water',
                        style: TextStyle(
                            fontSize: Config.textSize(context, 5),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: Config.yMargin(context, 1.5)),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        initialValue: waterReminder.selectedMl?.toString() ??
                            3000.toString(),
                        onChanged: (val) =>
                            waterReminder.updateSelectedMl(int.parse(val)),
                        // controller: mlTextController,
                        cursorColor: Theme.of(context).primaryColorDark,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.xMargin(context, 5.5)),
                        decoration: InputDecoration(
                          hintText: 'Input water quantity for intervals...',
                          hintStyle: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.xMargin(context, 5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Config.xMargin(context, 5))),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Config.xMargin(context, 5))),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
//                Container(
//                  height: height * 0.4,
//                  child: GridView.count(
//                    primary: false,
//                    padding: EdgeInsets.symmetric(
//                        horizontal: Config.xMargin(context, 3),
//                        vertical: Config.yMargin(context, 2)),
//                    crossAxisSpacing: 10,
//                    mainAxisSpacing: 10,
//                    crossAxisCount: 3,
//                    children: waterReminder.mls.map((ml) {
//                      return GestureDetector(
//                        onTap: () => waterReminder.updateSelectedMl(ml),
//                        child: Container(
//                          decoration: BoxDecoration(
//                            boxShadow: [
//                              BoxShadow(
//                                color: Theme.of(context)
//                                    .primaryColorDark
//                                    .withOpacity(0.03),
//                                blurRadius: 2,
//                                spreadRadius: 2,
//                                offset: Offset(0, 3),
//                              )
//                            ],
//                            color: waterReminder.getGridItemColor(context, ml),
//                            borderRadius: BorderRadius.circular(width * 0.03),
//                          ),
//                          alignment: Alignment.center,
//                          child: Text(
//                            '$ml' + 'ml',
//                            style: waterReminder.gridItemTextStyle(context, ml),
//                          ),
//                        ),
//                      );
//                    }).toList(),
//                  ),
//                ),
                //Description Text Input
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.xMargin(context, 7)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: Config.textSize(context, 5),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: Config.yMargin(context, 1.5)),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        initialValue: waterReminder.description ?? '',
                        // controller: descriptionTextController,
                        onChanged: (val) =>
                            waterReminder.updateDescription(val),
                        cursorColor: Theme.of(context).primaryColorDark,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.xMargin(context, 5.5)),
                        decoration: InputDecoration(
                          hintText: 'Optional Description...',
                          hintStyle: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.xMargin(context, 5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Config.xMargin(context, 5))),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Config.xMargin(context, 5))),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(
                      left: Config.xMargin(context, 3.5),
                      right: Config.xMargin(context, 3.5),
                      bottom: Config.yMargin(context, 1)),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: waterReminder.selectedMl != null &&
                              waterReminder.selectedMonth != null &&
                              waterReminder.selectedDay != null &&
                              waterReminder.selectedStartTime != null
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor.withOpacity(0.7),
                      padding: EdgeInsets.symmetric(
                          // horizontal: Config.xMargin(context, 10),
                          vertical: Config.yMargin(context, 3)),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.03),
                      ),
                      onPressed: waterReminder.selectedMl != null &&
                              // waterReminder.selectedMonth != null &&
                              // waterReminder.selectedDay != null &&
                              waterReminder.selectedStartTime != null
                          ? () async {
                              //here the function to save the schedule can be executed, by formatting the selected date as _today.year-selectedMonth-selectedDay i.e YYYY-MM-DD
                              // Navigator.of(context).pop();
                              var diff = waterReminder
                                  .getEndDateTime()
                                  .difference(waterReminder.getDateTime())
                                  .inMinutes;

                              double numb =
                                  diff / waterReminder.selectedInterval;
                              for (var i = 1; i < numb + 1; i++) {
                                if (waterReminder.selectedDay ==
                                        DateTime.now().day &&
                                    waterReminder.selectedMonth ==
                                        DateTime.now().month) {
                                  var timeValue =
                                      waterReminder.getDateTime().add(
                                            Duration(
                                                minutes: i == 1
                                                    ? 0
                                                    : waterReminder
                                                            .selectedInterval *
                                                        i),
                                          );
                                  await waterReminderDB
                                      .addWaterReminder(
                                          waterReminder.createSchedule(
                                              notifyDateTime: timeValue))
                                      .then((value) => waterNotificationManager
                                          .showWaterNotificationDaily(
                                              id: waterReminder.selectedDay +
                                                  timeValue.minute,
                                              title:
                                                  'It\' s time to take some Waters',
                                              body:
                                                  'Take ${waterReminder.selectedMl} ml of Water ',
                                              dateTime: timeValue));
                                }
                              }
                              // print(numb.floor());
                              waterReminder.createSchedule();
                            }
                          : null,
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.bold,
                            fontSize: Config.textSize(context, 5)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
