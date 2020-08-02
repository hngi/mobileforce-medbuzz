import 'package:MedBuzz/core/database/fitness_reminder.dart';
import 'package:MedBuzz/core/database/medication_data.dart';
import 'package:MedBuzz/core/database/notification_data.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/medication_reminders/all_medications_reminder_model.dart';
import 'package:MedBuzz/ui/views/reminder_description_card/new_all_reminders_model.dart';
import 'package:MedBuzz/ui/views/reminder_description_card/new_medication_card/medication_card.dart';
import 'package:MedBuzz/ui/views/reminder_description_card/reminder_description_card_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/database/diet_reminderDB.dart';
import 'reminders_description_card.dart';

class NewAllReminderScreen extends StatefulWidget {
  @override
  _NewAllReminderScreenState createState() => _NewAllReminderScreenState();
}

class _NewAllReminderScreenState extends State<NewAllReminderScreen> {
  @override
  void initState() {
    Provider.of<ReminderDescriptionCardModel>(context, listen: false)
        .loadPointsFromDb();
    // Provider.of<DietReminderDB>(context, listen: false).getAlldiets();
    // Provider.of<FitnessReminderCRUD>(context, listen: false).getReminders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var fitModel = Provider.of<FitnessReminderCRUD>(context);
    var dietModel = Provider.of<DietReminderDB>(context);
    var notificationDB = Provider.of<NotificationData>(context);
    notificationDB.getNotifications();

    dietModel.getAlldiets();
    fitModel.getReminders();

    var medsModel = Provider.of<MedicationsSchedulesModel>(context);
    var medData = Provider.of<MedicationData>(context);
    // var model = Provider.of<NewAllReminderModel>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: null,
          elevation: 0.0,
          title: Text(
            'Notifications',
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Config.xMargin(context, 4),
                  vertical: Config.yMargin(context, 1)),
              child: Container(
                width: width,
                child: Column(
                  children: <Widget>[
                    //container with custom greeting and some weird ass abacus-looking stats
                    // Container(
                    //   width: width,
                    //   height: height * .25,
                    //   decoration: BoxDecoration(
                    //     color: Theme.of(context).primaryColor,
                    //     borderRadius:
                    //         BorderRadius.circular(Config.xMargin(context, 3)),
                    //   ),
                    //   child: Column(children: <Widget>[
                    //     Row(
                    //       children: <Widget>[
                    //         //first column for greeting and some text
                    //         Container(
                    //           width: width * .45,
                    //           height: height * .25,
                    //           margin: EdgeInsets.only(
                    //               left: Config.xMargin(context, 2.77)),
                    //           child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: <Widget>[
                    //               Text(
                    //                 model.getGreeting(context),
                    //                 style: TextStyle(
                    //                     fontWeight: FontWeight.w600,
                    //                     fontSize: Config.xMargin(context, 5),
                    //                     color: Theme.of(context).primaryColorLight),
                    //               ),
                    //               SizedBox(height: Config.yMargin(context, 1)),
                    //               Text(
                    //                 model.getUserProgress(),
                    //                 textAlign: TextAlign.start,
                    //                 style: TextStyle(
                    //                     fontSize: Config.xMargin(context, 3.85),
                    //                     color: Theme.of(context)
                    //                         .primaryColorLight
                    //                         .withOpacity(.5)),
                    //               ),
                    //             ],
                    //           ),
                    //         ),

                    //         //second column for stats
                    //         Column(
                    //           children: <Widget>[
                    //             Container(
                    //               width: width * .45,
                    //               height: height * .25,
                    //               child: Column(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceAround,
                    //                   children: <Widget>[
                    //                     //this should be replaced with the design asset
                    //                     //was just trying some things
                    //                     Container(
                    //                         width: width * .45,
                    //                         height: height * .18,
                    //                         child: Row(
                    //                           children: <Widget>[
                    //                             SingleChildColumn(text: "M")
                    //                           ],
                    //                         )),
                    //                     Text(
                    //                       'stats for the week',
                    //                       style: TextStyle(
                    //                           fontSize:
                    //                               Config.xMargin(context, 3.85),
                    //                           color: Theme.of(context)
                    //                               .primaryColorLight
                    //                               .withOpacity(.5)),
                    //                     )
                    //                   ]),
                    //             )
                    //           ],
                    //         )
                    //       ],
                    //     )
                    //   ]),
                    // ),
                    //commented out for presentation purposes

                    //logic to populate all reminders from the db with RemindersDescriptionCard widget goes here

                    //This is the logic to populate Medication Reminders to the new screen
                    Visibility(
                      visible: false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Config.yMargin(context, 20.0)),
                        child: Container(
                          child:
                              Text('No medication reminder set for this date'),
                        ),
                      ),
                    ),
                    // for (var notification in notificationDB.notifications)
                    //   Text(notification.dateTime.toString()),

                    for (var medicationReminder in medsModel
                        .medicationReminderBasedOnDateTime
                        .where((element) =>
                            element.firstTime[1] <= TimeOfDay.now().minute)
                        .toList())
                      NewMedicationCard(
                        medRem: medicationReminder,
                        time: medData.firstTime.format(context),
                        height: height * .23,
                        width: width,
                      ),
                    if (medData.secondTime != null)
                      for (var medicationReminder in medsModel
                          .medicationReminderBasedOnDateTime
                          .where((element) =>
                              element.secondTime[1] <= TimeOfDay.now().minute)
                          .toList())
                        NewMedicationCard(
                          medRem: medicationReminder,
                          time: medData.secondTime.format(context),
                          height: height * .23,
                          width: width,
                        ),
                    if (medData.thirdTime != null)
                      for (var medicationReminder in medsModel
                          .medicationReminderBasedOnDateTime
                          .where((element) =>
                              element.thirdTime[1] <= TimeOfDay.now().minute)
                          .toList())
                        NewMedicationCard(
                          medRem: medicationReminder,
                          time: medData.thirdTime.format(context),
                          height: height * .23,
                          width: width,
                        ),

                    for (var fitnessReminder in fitModel
                        .fitnessRemindersBasedOnDateTime
                        .where((element) =>
                            element.activityTime[1] <= TimeOfDay.now().minute)
                        .toList())
                      RemindersDescriptionCard(
                        model: fitnessReminder,
                        height: height,
                        width: width,
                      ),
                    for (var dietReminder in dietModel
                        .dietRemindersBasedOnDateTime
                        .where((element) =>
                            element.startDate.minute <= TimeOfDay.now().minute)
                        .toList())
                      RemindersDescriptionCard(
                        model: dietReminder,
                        height: height,
                        width: width,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class SingleChildColumn extends StatelessWidget {
  final String text;

  const SingleChildColumn({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(children: <Widget>[
      divider(height, width, context),
      space(context),
      divider(height, width, context),
      space(context),
      divider(height, width, context),
      space(context),
      divider(height, width, context),
      space(context),
      Text(
        text,
        style: TextStyle(
            fontSize: Config.xMargin(context, 3.85),
            color: Theme.of(context).primaryColorLight.withOpacity(.5)),
      ),
      space(context),
    ]);
  }

  Widget divider(double height, double width, BuildContext context) =>
      Container(
        color: Theme.of(context).buttonColor,
        height: height * 0.03,
        width: width * 0.008,
        child: VerticalDivider(),
      );

  Widget space(BuildContext context) =>
      SizedBox(height: Config.yMargin(context, .5));
}
