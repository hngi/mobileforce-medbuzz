import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/appointmentData.dart';
import 'package:MedBuzz/core/notifications/appointment_notification_manager.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/schedule_appointment_screen_model.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatefulWidget {
  final double height;
  final double width;

  final ScheduleAppointmentModel model;
  final Appointment appointment;
  AppointmentCard({
    Key key,
    this.height,
    this.width,
    this.appointment,
    this.model,
  }) : super(key: key);

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  final AppointmentNotificationManager notificationManager =
      AppointmentNotificationManager();

  final AppointmentData db = AppointmentData();

  final ScheduleAppointmentModel scheduleModel = ScheduleAppointmentModel();

  @override
  Widget build(BuildContext context) {
    final double boxHeight = MediaQuery.of(context).size.height;
    initializeDateFormatting();
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: widget.height * 0.02),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Config.xMargin(context, 3),
                vertical: Config.yMargin(context, 1)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Config.xMargin(context, 6)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColorLight,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox.fromSize(
                  size: Size(
                      Config.xMargin(context, 5), Config.yMargin(context, 2)),
                  child: PopupMenuButton(
                      tooltip: 'Options',
                      padding: EdgeInsets.only(right: 58),
                      icon: Icon(Icons.more_vert,
                          size: Config.textSize(context, 5)),
                      onSelected: (_) {
                        PopupMenuItem(
                            child: GestureDetector(
                          child: Text('View'),
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RouteNames.viewAppointmentScreen);
                          },
                        ));
                        PopupMenuItem(
                            child: GestureDetector(
                          child: Text('Delete'),
                          onTap: () {
                            notificationManager
                                .removeReminder(scheduleModel.selectedDay);
                            db.deleteAppointment(widget.appointment.dateTime);
                          },
                        ));
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                              child: GestureDetector(
                            child: Text('View'),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, RouteNames.viewAppointmentScreen);
                            },
                          )),
                          PopupMenuItem(
                              child: GestureDetector(
                            child: Text('Delete'),
                            onTap: () {
                              notificationManager
                                  .removeReminder(scheduleModel.selectedDay);
                              db.deleteAppointment(widget.appointment.dateTime);
                            },
                          )),
                        ];
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.MMMM().format(widget.appointment.date),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Config.textSize(context, 3),
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          '${widget.appointment.date.day}',
                          style: TextStyle(
                            fontSize: Config.textSize(context, 7),
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
                        Text(
                          DateFormat.E().format(widget.appointment.date),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Config.textSize(context, 3),
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Config.xMargin(context, 3),
                    ),
                    Container(
                      color: Theme.of(context).primaryColorDark,
                      height: widget.height * 0.07,
                      width: widget.width * 0.001,
                      child: VerticalDivider(),
                    ),
                    SizedBox(width: Config.xMargin(context, 5)),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Timing',
                                      style: TextStyle(
                                        fontSize: Config.textSize(context, 3.4),
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Config.yMargin(context, 1),
                                    ),
                                    Text(
                                      widget.appointment.dateTime
                                          .substring(0, 5),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              Config.textSize(context, 3.8)),
                                    ),
                                  ],
                                ),
                                SizedBox(width: Config.xMargin(context, 9)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Appointment for',
                                      style: TextStyle(
                                        fontSize: Config.textSize(context, 3.4),
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Config.yMargin(context, 1),
                                    ),
                                    Text(
                                      widget.appointment.appointmentType,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              Config.textSize(context, 3.8)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: widget.height * 0.03,
                              width: double.infinity,
                              child: Divider(
                                color: Theme.of(context).primaryColorDark,
//indent: 50.0,
                                // endIndent: 10.0,
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.appointment.note,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: Config.textSize(context, 3.8)),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: boxHeight * 0.03),
        ],
      ),
    );
  }
}
