import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/schedule_appointment_screen_model.dart';
import 'package:MedBuzz/ui/views/water_reminders/single_water_screen.dart';
import 'package:MedBuzz/ui/widget/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/core/database/appointmentData.dart';
import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewAppointment extends StatelessWidget {
  static const routeName = 'view-schedule-appointment-reminder';
  DateTime time = DateTime.now();
  String formattedTime;
  final Appointment appointment;

  ViewAppointment({this.appointment});

  @override
  Widget build(BuildContext context) {
    var appointmentModellerDB = Provider.of<AppointmentData>(context, listen:true);

    var appointmentReminder = Provider.of<ScheduleAppointmentModel>(context, listen: true);

    final appointmentInfo = appointmentModellerDB.getAppointments();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appointmentReminder.updateAvailableAppointmentReminder(appointmentModellerDB.appointment);
    });

    formattedTime = DateFormat.jm().format(time);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //Set Widget to use Provider
    return Consumer<AppointmentData>(
      builder: (context, appointmentModel, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            leading: Icon(Icons.arrow_back),
            elevation: 2.0,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(Config.yMargin(context, 2.6)),
                  child: FlatButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          child: DeleteDialog(),
                        );
                        showSnackBar(context);
                        Future.delayed(Duration(seconds: 1)).then((value) {
                          appointmentModellerDB.deleteAppointment(appointment.dateTime);
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      label: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      )),
                ),
                //SizedBox(height: Config.yMargin(context, 3)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.xMargin(context, 5.33)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Meet John \nLucas',
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
                            'A quick run from home to the estate junction and back home.',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.normal,
                              fontSize: Config.textSize(context, 4),
                            ),
                          ),
                        ),
                        SizedBox(height: Config.yMargin(context, 7)),
                        Text(
                          'Frequency',
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
                                '30 minutes weekly',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: Config.textSize(context, 4),
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              Text(
                                '8:00AM',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Config.textSize(context, 3.6),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: Config.yMargin(context, 7)),
                        Text(
                          'Length',
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
                            '4 days left out of 30 days',
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
                      Navigator.pushNamed(
                          context, RouteNames.scheduleAppointmentScreen);
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
