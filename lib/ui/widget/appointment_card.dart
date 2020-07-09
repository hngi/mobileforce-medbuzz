import 'package:MedBuzz/core/database/appointmentData.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/all_scheduled_appointment_reminders.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/schedule_appointment_screen_model.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final double height;
  final double width;

  final ScheduleAppointmentModel model;
  final Appointment appointment;
  const AppointmentCard({
    Key key,
    this.height,
    this.width,
    this.appointment,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: height * 0.02),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Config.xMargin(context, 3),
                vertical: Config.yMargin(context, 1)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Config.xMargin(context, 6)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
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
                      onSelected: (_) {},
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                              child: GestureDetector(
                            child: Text(
                              'Edit',
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {},
                          )),
                          PopupMenuDivider(
                            height: height * 0.02,
                          ),
                          PopupMenuItem(
                              child: GestureDetector(
                            child: Text(
                              'Delete',
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {
                              asyncConfirmDialog(context);
                            },
                          )),
                        ].toList();
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.MMMM().format(appointment.date),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Config.textSize(context, 3),
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Text(
                          '${appointment.date.day}',
                          style: TextStyle(
                            fontSize: Config.textSize(context, 7),
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
                        Text(
                          DateFormat.E().format(appointment.date),
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
                      height: height * 0.07,
                      width: width * 0.001,
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
                                      appointment.dateTime.substring(0, 5),
                                      style: TextStyle(
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
                                      appointment.appointmentType,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              Config.textSize(context, 3.8)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                              width: double.infinity,
                              child: Divider(
                                color: Theme.of(context).primaryColorDark,
//indent: 50.0,
                                // endIndent: 10.0,
                              ),
                            ),
                            Container(
                              child: Text(
                                appointment.note,
                                style: TextStyle(
                                    fontSize: Config.textSize(context, 3.8)),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
