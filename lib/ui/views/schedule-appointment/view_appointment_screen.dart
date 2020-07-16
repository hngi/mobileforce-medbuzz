import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:MedBuzz/core/notifications/appointment_notification_manager.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/schedule_appointment_reminder_screen.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/schedule_appointment_screen_model.dart';
import 'package:MedBuzz/ui/views/water_reminders/single_water_screen.dart';
import 'package:MedBuzz/ui/widget/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/core/database/appointmentData.dart';
import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:MedBuzz/ui/widget/appBar.dart';

class ViewAppointment extends StatefulWidget {
  static const routeName = 'view-schedule-appointment-reminder';
  final Appointment appointment;

  ViewAppointment({this.appointment});

  @override
  _ViewAppointmentState createState() => _ViewAppointmentState();
}

class _ViewAppointmentState extends State<ViewAppointment> {
  DateTime time = DateTime.now();

  String formattedTime;
  final appointmentDB = AppointmentData();

  @override
  Widget build(BuildContext context) {
    final AppointmentNotificationManager notificationManager =
        AppointmentNotificationManager();
    var appointmentModellerDB =
        Provider.of<AppointmentData>(context, listen: true);

    var appointmentReminder =
        Provider.of<ScheduleAppointmentModel>(context, listen: true);

    final appointmentInfo = appointmentModellerDB.getAppointments();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appointmentReminder.updateAvailableAppointmentReminder(
          appointmentModellerDB.appointment);
    });

    formattedTime = DateFormat.jm().format(time);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //Set Widget to use Provider
    return Consumer<AppointmentData>(
      builder: (context, appointmentModel, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: appBar(context: context, actions: [
            FlatButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    child: DeleteDialog(
                      appointment: widget.appointment,
                    ),
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                )),
          ]),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Padding(
                //   padding: EdgeInsets.all(Config.yMargin(context, 2.6)),
                //   child: FlatButton.icon(
                //       onPressed: () {
                //         showDialog(
                //           context: context,
                //           child: DeleteDialog(
                //             appointment: widget.appointment,
                //           ),
                //         );
                //       },
                //       icon: Icon(
                //         Icons.delete,
                //         color: Colors.red,
                //       ),
                //       label: Text(
                //         'Delete',
                //         style: TextStyle(color: Colors.red),
                //       )),
                // ),
                //SizedBox(height: Config.yMargin(context, 3)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.xMargin(context, 5.33)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.appointment.appointmentType,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: Config.textSize(context, 5.3),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(right: Config.xMargin(context, 5)),
                        child: Image.asset('images/appointment.png'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Config.yMargin(context, 6)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                    horizontal: Config.xMargin(context, 5.33),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Description',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.textSize(context, 4.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Config.yMargin(context, 0.5)),
                          child: Text(
                            widget.appointment.note.isEmpty
                                ? 'None'
                                : widget.appointment.note.trim(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.normal,
                              fontSize: Config.textSize(context, 4),
                            ),
                          ),
                        ),
                        SizedBox(height: Config.yMargin(context, 7)),
                        Text(
                          'Timing',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.textSize(context, 4),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Config.yMargin(context, 0.5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${widget.appointment.time[0]}:${widget.appointment.time[1]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Config.textSize(context, 5.33),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: Config.yMargin(context, 7)),
                        Text(
                          'Date',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: Config.textSize(context, 4),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Config.yMargin(context, 0.5)),
                          child: Text(
                            '${widget.appointment.date.day} - ${widget.appointment.date.month} - ${widget.appointment.date.year}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).primaryColorDark,
                              fontSize: Config.textSize(context, 4),
                            ),
                          ),
                        ),
                      ]),
                ),
                SizedBox(height: Config.yMargin(context, 18)),

                Padding(
                  padding:
                      EdgeInsets.only(bottom: Config.yMargin(context, 2.0)),
                  child: InkWell(
                    onTap: () {
                      appointmentModel.isEditing = true;
                      notificationManager
                          .removeReminder(appointmentReminder.selectedDay);
                      // appointmentDB.deleteAppointment(widget.appointment.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScheduleAppointmentScreen(
                                  appointment: widget.appointment,
                                  buttonText: 'Update',
                                )),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(Config.xMargin(context, 3.55)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Config.yMargin(context, 1.28))),
                        color: Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: Config.xMargin(context, 5.33),
                          right: Config.xMargin(context, 6)),
                      //24,24,27
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.bold,
                          fontSize: Config.textSize(context, 4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DeleteDialog extends StatelessWidget {
  DeleteDialog({this.appointment});
  final Appointment appointment;
  final AppointmentData db = AppointmentData();
  final ScheduleAppointmentModel scheduleModel = ScheduleAppointmentModel();
  final AppointmentNotificationManager notificationManager =
      AppointmentNotificationManager();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Config.xMargin(context, 4.0)),
      ),
      child: Container(
        height: Config.yMargin(context, 20),
        width: Config.xMargin(context, 150.0),
        //width: Config.xMargin(context, 50),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 23.0, bottom: 20.0),
                child: Text(
                  'Are you sure you want to delete this?',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: Config.yMargin(context, 6.0),
                    width: Config.xMargin(context, 30.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      color: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Config.xMargin(context, 2.0)),
                        side: BorderSide(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.4),
                            width: 1.5),
                      ),
                    ),
                  ),
                  Container(
                    height: Config.yMargin(context, 6.0),
                    width: Config.xMargin(context, 30.0),
                    child: FlatButton(
                      onPressed: () {
                        notificationManager
                            .removeReminder(scheduleModel.selectedDay);
                        db.deleteAppointment(appointment.id);
                        Navigator.popAndPushNamed(context, RouteNames.homePage);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      color: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Config.xMargin(context, 2.0)),
                        side: BorderSide(
                            color: Theme.of(context).hintColor.withOpacity(.4),
                            width: 1.5),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
