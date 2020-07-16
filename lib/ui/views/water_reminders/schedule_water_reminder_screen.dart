import 'package:MedBuzz/core/database/user_db.dart';
import 'package:MedBuzz/core/database/water_taken_data.dart';
import 'package:MedBuzz/core/models/water_reminder_model/water_reminder.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/water_reminders/schedule_water_reminder_model.dart';
import 'package:MedBuzz/ui/widget/time_wheel.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/database/waterReminderData.dart';
import '../../../core/notifications/water_notification_manager.dart';

class ScheduleWaterReminderScreen extends StatelessWidget {
  //values of water measures - stored as int in case of any need to calculate
  static const routeName = 'schedule-water-reminder';
  final bool isEdit;
  final WaterReminder selectedWaterReminder;
  final ItemScrollController _scrollController = ItemScrollController();
  // ScheduleWaterReminderScreen();
  final TextEditingController descriptionTextController =
      TextEditingController();
  final TextEditingController intervalTextController = TextEditingController();
  final TextEditingController mlTextController = TextEditingController();
  ScheduleWaterReminderScreen(
      {this.selectedWaterReminder, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    var userDb = Provider.of<UserCrud>(context);
    userDb.getuser();
    var waterReminder =
        Provider.of<ScheduleWaterReminderViewModel>(context, listen: true);
    var waterReminderDB = Provider.of<WaterReminderData>(context, listen: true);
    waterReminderDB.getWaterReminders();
    var waterTakenDB = Provider.of<WaterTakenData>(context, listen: true);
    waterTakenDB.getWaterTaken();
    WaterNotificationManager waterNotificationManager =
        WaterNotificationManager();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      waterReminder.updateAvailableReminders(waterReminderDB.waterReminders);
      if (isEdit) {
        // waterReminder.updateSelectedMl(selectedWaterReminder.ml);
        // waterReminder
        //     .updateSelectedDay(selectedWaterReminder.startTime.day - 1);
        // waterReminder.updateSelectedMonth(selectedWaterReminder.startTime.month);
        // waterReminder.updateSelectedMl(selectedWaterReminder.ml);
        // waterReminder.updateSelectedMl(selectedWaterReminder.ml);
        // waterReminder.updateSelectedMl(selectedWaterReminder.ml);
      }
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Theme.of(context).primaryColorDark),
          title: Text(
            '${!isEdit ? 'Add a' : 'Edit'} water reminder',
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
                    value: isEdit
                        ? monthValues[selectedWaterReminder.startTime.month - 1]
                            .month
                        : waterReminder.currentMonth,
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
                    initialScrollIndex: isEdit
                        ? selectedWaterReminder.startTime.day - 1
                        : waterReminder.selectedDay - 1,
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
                            color: isEdit
                                ? index ==
                                            selectedWaterReminder
                                                    .startTime.day -
                                                1 ||
                                        waterReminder.isActive(index)
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.07)
                                : waterReminder.getButtonColor(
                                    context,
                                    index,
                                  ),
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
                      DescribedFeatureOverlay(
                        featureId: 'feature2',
                        tapTarget: Text('Get Started!'),
                        // onComplete: () async {

                        //   return true;
                        // },
                        title: Text('Flexible Time Schedules'),
                        description: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                'Set your preferred time on the timewheel when you want to receive reminders for your goal and the intervals you would want to get them'),
                            TimeWheel(
                              updateTimeChanged: (_) => print(_),
                            ),
                          ],
                        ),
                        child: Text(
                          'Wake Time',
                          style: TextStyle(
                            fontSize: Config.textSize(context, 4),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Container(
                        // this also acts like a negative margin to get rid of the excess space from moving the grid up
                        alignment: Alignment.topCenter,
                        child: Container(
                          // height: height * 0.15,
                          child: TimeWheel(
                            initialValue: selectedWaterReminder?.startTime,
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
                      Text(
                        'Sleep Time',
                        style: TextStyle(
                          fontSize: Config.textSize(context, 4),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Container(
                        // this also acts like a negative margin to get rid of the excess space from moving the grid up
                        alignment: Alignment.topCenter,
                        child: Container(
                          // height: height * 0.15,
                          child: TimeWheel(
                            initialValue: selectedWaterReminder?.endTime,
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
                        initialValue: !isEdit
                            ? waterReminder.selectedInterval?.toString() ?? ''
                            : selectedWaterReminder.interval.toString(),
                        onChanged: (val) => waterReminder
                            .updateSelectedInterval(int.parse(val)),
                        // controller: intervalTextController,
                        cursorColor: Theme.of(context).primaryColorDark,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.xMargin(context, 5.5)),
                        decoration: InputDecoration(
                          hintText: 'Input interval for reminder...',
                          hintStyle: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: Config.xMargin(context, 4.5),
                          ),
                          suffixText: 'Minutes',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Config.xMargin(context, 5))),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
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
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.xMargin(context, 7)),
                  child: Text(
                    'Quantity of Water',
                    style: TextStyle(
                        fontSize: Config.textSize(context, 5),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: height * 0.3,
                  child: GridView.count(
                    primary: false,
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.xMargin(context, 7),
                        vertical: Config.yMargin(context, 2)),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    children: waterReminder.mls.map((ml) {
                      return GestureDetector(
                        onTap: () => waterReminder.updateSelectedMl(ml),
                        child: Container(
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
                            color: waterReminder.getGridItemColor(context, ml),
                            borderRadius: BorderRadius.circular(width * 0.03),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$ml' + 'ml',
                            style: waterReminder.gridItemTextStyle(context, ml),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: height * 0.03),
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
                        initialValue: isEdit
                            ? selectedWaterReminder.description
                            : waterReminder.description ?? '',
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
                            color: Theme.of(context).hintColor,
                            fontSize: Config.xMargin(context, 4.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Config.xMargin(context, 5))),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
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
                              await waterReminderDB
                                  .addWaterReminder(!isEdit
                                      ? waterReminder.createSchedule()
                                      : WaterReminder(
                                          description:
                                              waterReminder.description,
                                          ml: waterReminder.selectedMl ??
                                              selectedWaterReminder.ml,
                                          startTime: waterReminder
                                                  ?.getDateTime() ??
                                              selectedWaterReminder.startTime,
                                          id: DateTime.now().toString(),
                                          endTime:
                                              waterReminder?.getEndDateTime() ??
                                                  selectedWaterReminder.endTime,
                                          interval: waterReminder
                                                  ?.selectedInterval ??
                                              selectedWaterReminder.interval))
                                  .then((val) {
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
                                    if (isEdit) {
                                      // waterTakenDB.deleteAll();
                                      // for (var reminder in waterReminderDB.waterReminders) {

                                      waterNotificationManager.removeReminder(
                                          selectedWaterReminder.startTime.day +
                                              timeValue.minute +
                                              60);
                                      // }
                                    }
                                    waterNotificationManager.showWaterNotificationDaily(
                                        id: waterReminder.selectedDay +
                                            timeValue.minute +
                                            60,
                                        title:
                                            'Hi ${userDb.user?.name}, It\' s time to take some water',
                                        body:
                                            'Take ${waterReminder.selectedMl} ml of Water ',
                                        dateTime: timeValue);
                                  }
                                }
                                isEdit
                                    ? waterReminderDB.deleteWaterReminder(
                                        selectedWaterReminder.id)
                                    : null;
                                // print(numb.floor());
                                Navigator.of(context).pop();
                              });
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
