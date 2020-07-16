import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/schedule_appointment_screen_model.dart';
import 'package:MedBuzz/ui/widget/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:MedBuzz/ui/size_config/config.dart';

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
  @override
  void initState() {
    Provider.of<ScheduleAppointmentModel>(context, listen: false)
        .updateAvailableAppointmentReminder(
            Provider.of<AppointmentData>(context, listen: false).appointment);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appointmentReminders =
        Provider.of<ScheduleAppointmentModel>(context, listen: true);

    var appointmentReminderDB =
        Provider.of<AppointmentData>(context, listen: true);
    appointmentReminderDB.getAppointments();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.color,
          title: Container(
            child: Container(
              child: new Text(
                'My Appointments',
                style: Theme.of(context).textTheme.headline6,
                textScaleFactor: 1.2,
              ),
            ),
          ),
          leading: Container(
            child: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                color: Theme.of(context).appBarTheme.iconTheme.color,
              ),

              // navigate to add appointments page

              onPressed: () => {
                Navigator.pushReplacementNamed(context, RouteNames.homePage)
              },
            ),
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColorDark.withOpacity(0.9),
            unselectedLabelColor:
                Theme.of(context).primaryColorDark.withOpacity(0.9),
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
                  style: TextStyle(fontSize: Config.textSize(context, 4)),
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
                        visible:
                            appointmentReminders.upcomingApointments.isEmpty,
                        child: Container(
                          width: width,
                          height: height * .8,
                          child: Center(
                              child: Text('No Appointments for this date')),
                        )),
                    for (var appointment
                        in appointmentReminders.upcomingApointments)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Config.xMargin(context, 5.0)),
                        child: AppointmentCard(
                          height: height,
                          width: width,
                          appointment: appointment,
                        ),
                      ),
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
                          width: width,
                          height: height * .8,
                          child: Center(child: Text('No Past Appointments')),
                        )),
                    for (var appointment
                        in appointmentReminders.pastApointments)
//                        if (DateTime.now()
//                            .isAfter(appointmentReminders.selectedDateTime))
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Config.xMargin(context, 5.0)),
                        child: AppointmentCard(
                          height: height,
                          width: width,
                          appointment: appointment,
                        ),
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
          style: Theme.of(context).textTheme.headline6,
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
            color: Theme.of(context).primaryColorDark.withOpacity(0.2),
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
            color: Theme.of(context).primaryColorDark.withOpacity(0.2),
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
