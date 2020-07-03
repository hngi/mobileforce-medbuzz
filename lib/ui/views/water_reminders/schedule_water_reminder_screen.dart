import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/water_reminders/schedule_water_reminder_model.dart';
import 'package:MedBuzz/ui/widget/time_wheel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/constants/route_names.dart';
import '../../../core/database/waterReminderData.dart';

class ScheduleWaterReminderScreen extends StatelessWidget {
  //values of water measures - stored as int in case of any need to calculate
  static const routeName = 'schedule-water-reminder';
  final ItemScrollController _scrollController = ItemScrollController();
  ScheduleWaterReminderScreen();

  @override
  Widget build(BuildContext context) {
    var waterReminder =
        Provider.of<ScheduleWaterReminderViewModel>(context, listen: true);
    var waterReminderDB = Provider.of<WaterReminderData>(context, listen: true);
    waterReminderDB.getWaterReminders();
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      Text('Time'),
                      SizedBox(height: height * 0.01),
                      Container(
                        // this also acts like a negative margin to get rid of the excess space from moving the grid up
                        alignment: Alignment.topCenter,
                        child: Container(
                          // height: height * 0.15,
                          child: TimeWheel(
                            updateTimeChanged: (val) =>
                                waterReminder.updateSelectedTime(val),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: height * 0.01),
                Container(
                  height: height * 0.4,
                  child: GridView.count(
                    primary: false,
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.xMargin(context, 3),
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
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(
                      left: Config.xMargin(context, 3),
                      right: Config.xMargin(context, 3),
                      bottom: Config.yMargin(context, 1)),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: waterReminder.selectedMl != null &&
                              waterReminder.selectedMonth != null &&
                              waterReminder.selectedDay != null &&
                              waterReminder.selectedTime != null
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
                              waterReminder.selectedMonth != null &&
                              waterReminder.selectedDay != null &&
                              waterReminder.selectedTime != null
                          ? () {
                              //here the function to save the schedule can be executed, by formatting the selected date as _today.year-selectedMonth-selectedDay i.e YYYY-MM-DD
                              waterReminderDB.addWaterReminder(
                                  waterReminder.createSchedule());
                              Navigator.of(context)
                                  .pushNamed(RouteNames.allRemindersScreen);
                            }
                          : null,
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
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
