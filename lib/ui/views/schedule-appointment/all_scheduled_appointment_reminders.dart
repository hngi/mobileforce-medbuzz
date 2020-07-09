import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/ui/widget/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'dart:ui';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/all_scheduled_appointment_reminders_model.dart';
import 'package:provider/provider.dart';

import '../../../core/database/appointmentData.dart';
// import 'package:table_calendar/table_calendar.dart';

class ScheduledAppointmentsPage extends StatefulWidget {
  @override
  _ScheduledAppointmentsPageState createState() {
    return _ScheduledAppointmentsPageState();
  }
}

class _ScheduledAppointmentsPageState extends State<ScheduledAppointmentsPage> {
  String month = 'July';
  int dateno = 12;
  String day = 'Thurs';
  var items = ['hi', 'hello', 'good', 'new', 'hi', 'now'];
  dynamic reminderMessage = 'Make sure to make lots of friends.';

  @override
  Widget build(BuildContext context) {
    var appointmentReminders =
        Provider.of<AppointmentViewModel>(context, listen: true);

    var appointmentReminderDB =
        Provider.of<AppointmentData>(context, listen: true);
    appointmentReminderDB.getAppointments();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appointmentReminders.updateAvailableAppointmentReminders(
          appointmentReminderDB.appointment);
    });
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        backgroundColor: appThemeLight.backgroundColor,
        appBar: AppBar(
          backgroundColor: appThemeLight.appBarTheme.color,
          title: Container(
            child: Container(
              child: new Text(
                'My Appointments',
                style: appThemeLight.textTheme.headline6,
                textScaleFactor: 1.2,
              ),
            ),
          ),
          leading: Container(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: appThemeLight.appBarTheme.iconTheme.color,
              ),

              // navigate to add appointments page

              onPressed: () => {
                Navigator.pushReplacementNamed(context, RouteNames.homePage)
              },
            ),
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: appThemeLight.primaryColor,
            labelColor: appThemeLight.primaryColorDark.withOpacity(0.9),
            unselectedLabelColor:
                appThemeLight.primaryColorDark.withOpacity(0.9),
            indicatorWeight: 2.0,
            tabs: [
              Tab(
                child: Text(
                  'Upcoming',
                  textScaleFactor: 0.85,
                  style: TextStyle(fontSize: Config.textSize(context, 4)),
                ),
              ),
              Tab(
                child: Text(
                  'Past',
                  textScaleFactor: 0.85,
                  style: appThemeLight.textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushReplacementNamed(context, RouteNames.homePage);
            return Future.value(false);
          },
          child: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: appointmentReminders.allAppointments.isEmpty,
                        child: Container(
                          child: Center(
                              child: Text('No Appointments for this date')),
                        )),
                    for (var appointment
                        in appointmentReminders.allAppointments)
                      AppointmentCard(
                        height: height,
                        width: width,
                        appointment: appointment,
                      )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: appointmentReminders.pastApointments.isEmpty,
                        child: Container(
                          child: Center(child: Text('No Past Appointments')),
                        )),
                    for (var appointment
                        in appointmentReminders.pastApointments)
                      AppointmentCard(
                        height: height,
                        width: width,
                        appointment: appointment,
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ConfirmAction { Cancel, Delete }

Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'One appointment will be deleted.',
          style: appThemeLight.textTheme.headline6,
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
            color: appThemeLight.primaryColorDark.withOpacity(0.2),
            onPressed: () {
              // go back to scheduled appointments page
              Navigator.of(context).pop(ConfirmAction.Cancel);
            },
          ),
          FlatButton(
            child: const Text(
              'Delete',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 12.0,
                color: Colors.red,
              ),
            ),
            color: appThemeLight.primaryColorDark.withOpacity(0.2),
            onPressed: () {
              // delete action
              var currentAppointment;
              Provider.of<AppointmentData>(context, listen: false)
                  .deleteAppointment(currentAppointment.key);
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
              //Navigator.of(context).pop(ConfirmAction.Delete);
            },
          )
        ],
      );
    },
  );
}
