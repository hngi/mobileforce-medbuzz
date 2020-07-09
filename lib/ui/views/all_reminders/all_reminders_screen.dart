import 'package:MedBuzz/core/database/appointmentData.dart';
import 'package:MedBuzz/core/database/medication_data.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/all_reminders/all_reminders_view_model.dart';
import 'package:MedBuzz/ui/views/medication_reminders/all_medications_reminder_screen.dart';
import 'package:MedBuzz/ui/widget/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/database/waterReminderData.dart';
import '../../widget/water_reminder_card.dart';

class AllRemindersScreen extends StatelessWidget {
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemScrollController _monthScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    var allReminders = Provider.of<AllRemindersViewModel>(context);
    var waterReminderDB = Provider.of<WaterReminderData>(context);
    var appointmentReminderDB = Provider.of<AppointmentData>(context);
    appointmentReminderDB.getAppointments();

    waterReminderDB.getWaterReminders();
    var medicationDB = Provider.of<MedicationData>(context);
    medicationDB.getMedicationReminder();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allReminders
          .updateAvailableWaterReminders(waterReminderDB.waterReminders);

      allReminders
          .updateAvailableMedicationReminders(medicationDB.medicationReminder);
      allReminders.updateAvailableAppointmentReminders(
          appointmentReminderDB.appointment);
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color bgColor = Theme.of(context).backgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        //leading: BackButton(color: Theme.of(context).primaryColorDark),

        title: Text(
          'All reminders',
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        elevation: 0,
        backgroundColor: bgColor,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: Config.yMargin(context, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              //without specifying this height, flutter throws an error because of the grid
              height: height * 0.03,
              child: ScrollablePositionedList.builder(
                //sets default selected day to the index of Date.now() date
                initialScrollIndex: allReminders.selectedMonth - 1,
                itemScrollController: _monthScrollController,
                //dynamically sets the itemCount to the number of days in the currently selected month
                itemCount: monthValues.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      allReminders
                          .updateSelectedMonth(monthValues[index].month);
                      _monthScrollController.scrollTo(
                        index: index,
                        duration: Duration(seconds: 1),
                      );
                    },
                    child: Container(
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.008),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: Config.xMargin(context, 2)),
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: Config.xMargin(context, 4.5)),
                      child: Text(
                        monthValues[index].month.toUpperCase(),
                        style:
                            allReminders.calendarMonthTextStyle(context, index),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              //without specifying this height, flutter throws an error because of the grid
              height: height * 0.15,
              child: ScrollablePositionedList.builder(
                //sets default selected day to the index of Date.now() date
                initialScrollIndex: allReminders.selectedDay - 1,
                itemScrollController: _scrollController,
                //dynamically sets the itemCount to the number of days in the currently selected month
                itemCount: allReminders.daysInMonth,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      allReminders.updateSelectedDay(index);
                      _scrollController.scrollTo(
                        index: index,
                        duration: Duration(seconds: 1),
                      );
                    },
                    child: Container(
                      width: width * 0.2,
                      decoration: BoxDecoration(
                        color: allReminders.getButtonColor(context, index),
                        borderRadius: BorderRadius.circular(height * 0.02),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: Config.xMargin(context, 2)),
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: Config.xMargin(context, 4.5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (index + 1).toString(),
                            style:
                                allReminders.calendarTextStyle(context, index),
                          ),
                          SizedBox(height: Config.yMargin(context, 1.5)),
                          Text(
                            allReminders.getWeekDay(index),
                            style: allReminders.calendarSubTextStyle(
                                context, index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.05),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Config.xMargin(context, 7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Fitness',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    width: width,
                    child: GestureDetector(
                      //Navigate to screen with single reminder i.e the on user clicked on
                      onTap: () {},
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width,
                              height: height * .22,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/sprint.png'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(
                                    Config.xMargin(context, 6)),
                              ),
                            ),
                            SizedBox(height: Config.yMargin(context, 2)),
                            //Type of fitness exercise goes here
                            Text('Running',
                                style: TextStyle(
                                    fontSize: Config.textSize(context, 4),
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor)),
                            SizedBox(height: Config.yMargin(context, 0.6)),
                            Text('30 minutes daily',
                                style: TextStyle(
                                    fontSize: Config.textSize(context, 4.5),
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColorDark)),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.07),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Config.xMargin(context, 7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Medication',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Visibility(
                    visible:
                        allReminders.medicationReminderBasedOnDateTime.isEmpty,
                    child: Container(
                      child: Text('No Medication Reminder Set for this Date'),
                    ),
                  ),
                  for (var medicationReminder
                      in allReminders.medicationReminderBasedOnDateTime)
                    MedicationCard(
                      height: height,
                      width: width,
                      values: medicationReminder,
                      drugName: medicationDB.drugName,
                      drugType:
                          medicationDB.drugTypes[medicationDB.selectedIndex],
                      dosage: medicationDB.dosage,
                      selectedFreq: medicationDB.selectedFreq,
                    )
                ],
              ),
            ),
            SizedBox(height: height * 0.07),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Config.xMargin(context, 7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Water Tracker',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Visibility(
                      visible:
                          allReminders.waterRemindersBasedOnDateTime.isEmpty,
                      child: Container(
                        child: Text('No Water Reminder Set for this Date'),
                      )),
                  for (var waterReminder
                      in allReminders.waterRemindersBasedOnDateTime)
                    WaterReminderCard(
                        height: height,
                        width: width,
                        waterReminder: waterReminder)
                ],
              ),
            ),
            SizedBox(height: height * 0.07),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Config.xMargin(context, 7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Appointments',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Visibility(
                      visible: allReminders.appointmentsBasedOnDateTime.isEmpty,
                      child: Container(
                        child: Text('No Appointment Set for this Date'),
                      )),
                  for (var appointment
                      in allReminders.appointmentsBasedOnDateTime)
                    AppointmentCard(
                      height: height,
                      width: width,
                      appointment: appointment,
                    )
                ],
              ),
            ),
            SizedBox(height: height * 0.07),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Config.xMargin(context, 7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Diet',
                    style: TextStyle(
                      fontSize: Config.textSize(context, 5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.xMargin(context, 3),
                        vertical: Config.yMargin(context, 1)),
//              height: Config.yMargin(context, 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 5,
//blurRadius: 2,
//offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '6:00PM',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Config.textSize(context, 3),
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.more_vert,
                                size: Config.textSize(context, 5),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'July',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Config.textSize(context, 3),
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      fontSize: Config.textSize(context, 7),
                                      color: Theme.of(context).highlightColor,
                                    ),
                                  ),
                                  Text(
                                    'Thurs',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Config.textSize(context, 3),
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Config.xMargin(context, 3),
                            ),
                            Container(
                              color: Theme.of(context).primaryColorDark,
                              height: height * 0.07,
                              width: width * 0.001,
                              child: VerticalDivider(
                                indent: 25.0,
                                endIndent: 25.0,
                              ),
                            ),
                            SizedBox(
                              width: Config.xMargin(context, 5),
                            ),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Carbohydrate, protein and drinks'),
                                    SizedBox(
                                      height: Config.yMargin(context, 1),
                                      width: double.infinity,
                                    ),
                                    Divider(
                                      color: Theme.of(context).primaryColorDark,
                                      height: height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        FlatButton(
                                          child: Text('Skip'),
                                          onPressed: () {},
                                        ),
                                        FlatButton(
                                          onPressed: () {},
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.done),
                                              SizedBox(
                                                width: Config.xMargin(
                                                    context, 0.5),
                                              ),
                                              Text(
                                                'Done',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
