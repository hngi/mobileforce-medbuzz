import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/appointmentData.dart';
import 'package:MedBuzz/core/database/diet_reminderDB.dart';
import 'package:MedBuzz/core/database/fitness_reminder.dart';
import 'package:MedBuzz/core/database/medication_data.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/all_reminders/all_reminders_view_model.dart';
import 'package:MedBuzz/ui/views/fitness_reminders/all_fitness_reminders_screen.dart';
import 'package:MedBuzz/ui/views/medication_reminders/all_medications_reminder_screen.dart';
import 'package:MedBuzz/ui/widget/appointment_card.dart';
import 'package:MedBuzz/ui/widget/diet_card.dart';
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
    var fitnessReminderDB = Provider.of<FitnessReminderCRUD>(context);
    var dietReminderDB = Provider.of<DietReminderDB>(context);
    appointmentReminderDB.getAppointments();
    fitnessReminderDB.getReminders();

    waterReminderDB.getWaterReminders();
    var medicationDB = Provider.of<MedicationData>(context);
    medicationDB.getMedicationReminder();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allReminders
          .updateAvailableWaterReminders(waterReminderDB.waterReminders);
      allReminders.updateAvailableDietReminders(dietReminderDB.allDiets);
      allReminders
          .updateAvailableMedicationReminders(medicationDB.medicationReminder);
      allReminders.updateAvailableAppointmentReminders(
          appointmentReminderDB.appointment);
      allReminders
          .updateAvailableFitnessReminders(fitnessReminderDB.fitnessReminder);
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color bgColor = Theme.of(context).backgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pushNamed(context, RouteNames.homePage);
        //   },
        // ),
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
                  Visibility(
                      visible:
                          allReminders.fitnessRemindersBasedOnDateTime.length ==
                              0,
                      child: Text('No fitness reminders set yet')),
                  for (var fitnessReminder
                      in allReminders.fitnessRemindersBasedOnDateTime)
                    FitnessCard(
                      height: height,
                      width: width,
                      fitnessReminder: fitnessReminder,
                      selectedFreq: fitnessReminderDB.selectedFreq,
                      fitnessType: fitnessReminderDB
                          .fitnessType[fitnessReminderDB.selectedIndex],
                      startDate: fitnessReminderDB.startDate.toString(),
                    ),
                ],
              ),
            ),
            SizedBox(height: Config.yMargin(context, 4)),
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
                  Visibility(
                      visible: allReminders.appointmentsBasedOnDateTime.isEmpty,
                      child: Container(
                        child: Text('No Diet plan Set for this Date'),
                      )),
                  for (var diet in allReminders.dietRemindersBasedOnDateTime)
                    DietCard(
                      height: height,
                      width: width,
                      diet: diet,
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
