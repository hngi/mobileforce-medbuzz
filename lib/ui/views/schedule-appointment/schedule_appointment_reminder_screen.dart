import 'dart:ui';
import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/appointmentData.dart';
import 'package:MedBuzz/core/notifications/appointment_notification_manager.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/widget/appBar.dart';
import 'package:MedBuzz/ui/widget/scrollable_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../size_config/config.dart';
import 'package:MedBuzz/ui/widget/time_wheel.dart';
import 'schedule_appointment_screen_model.dart';

class ScheduleAppointmentScreen extends StatefulWidget {
  static const routeName = 'schedule-appointment-reminder';
  final String payload;

  ScheduleAppointmentScreen({Key key, this.payload}) : super(key: key);

  @override
  _ScheduleAppointmentScreenState createState() =>
      _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  final ItemScrollController _scrollController = ItemScrollController();

  final TextEditingController _typeOfAppointmentController =
      TextEditingController();

  final TextEditingController _noteController = TextEditingController();

  final ScheduleAppointmentModel appointmentSchedule =
      ScheduleAppointmentModel();

  ScheduleAppointmentModel appointmentModel = ScheduleAppointmentModel();

  String _updateMonth;

  @override
  void initState() {
    _updateMonth = appointmentModel.currentMonth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appointmentReminder =
        Provider.of<ScheduleAppointmentModel>(context, listen: true);

    var appointmentReminderDB =
        Provider.of<AppointmentData>(context, listen: true);

    appointmentReminderDB.getAppointments();
    AppointmentNotificationManager notificationManager =
        AppointmentNotificationManager();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appointmentReminder.updateAvailableAppointmentReminder(
          appointmentReminderDB.appointment);
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var model = Provider.of<ScheduleAppointmentModel>(context);
    Color bgColor = Theme.of(context).backgroundColor;
    return Scaffold(
      appBar: appBar(context: context, title: 'Add your appointment'),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton(
                    isExpanded: false,
                    icon: Icon(Icons.expand_more),
                    //set the value to the selected month and if null,  it defaults to the present date month from DateTime.now()
                    value: _updateMonth,
                    hint: Text(
                      'Month',
                      textAlign: TextAlign.center,
                    ),
                    items: monthValues
                        .map(
                          (month) => DropdownMenuItem(
                            child: Container(
                              child: Text(
                                month.month,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            ),
                            value: month.month,
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      appointmentReminder.updateSelectedMonth(val);

                      setState(() {
                        _updateMonth = val;
                      });
                    }),
              ),
              Container(
                // height helps to stop overflowing of this widget into divider
                height: height * 0.15,
                child: ScrollablePositionedList.builder(
                  // sets default selected day to index of Date.now() date
                  initialScrollIndex: appointmentReminder.selectedDay - 1,
                  itemScrollController: _scrollController,

                  //dynamically sets the itemCount to the number of days in the currently selected month
                  itemCount: appointmentReminder.daysInMonth,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        appointmentReminder.updateSelectedDay(index);

                        _scrollController.scrollTo(
                          index: index,
                          duration: Duration(seconds: 1),
                        );
                      },
                      child: Container(
                        width: width * 0.2,
                        decoration: BoxDecoration(
                          color: appointmentReminder.getButtonColor(
                              context, index),
                          borderRadius: BorderRadius.circular(height * 0.04),
                        ),
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.only(left: Config.xMargin(context, 2)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (index + 1).toString(),
                              style: appointmentReminder.calendarTextStyle(
                                  context, index),
                            ),
                            SizedBox(height: Config.yMargin(context, 1.5)),
                            Text(
                              appointmentReminder.getWeekDay(index),
                              style: appointmentReminder.calendarSubTextStyle(
                                  context, index),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: Config.yMargin(context, 2),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Time',
                    style: TextStyle(
                        fontSize: Config.textSize(context, 4.8),
                        color: Theme.of(context).hintColor),
                  ),
                  SizedBox(
                    height: Config.yMargin(context, 1),
                  ),
                  Container(
                    child: TimeWheel(
                        updateTimeChanged: (value) =>
                            appointmentReminder.updateSelectedTime(value)),
                  ),
                  SizedBox(
                    height: Config.yMargin(context, 3.5),
                  ),
                  Text(
                    'Appointment For:',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColorDark),
                  ),
                  SizedBox(
                    height: Config.yMargin(context, 2),
                  ),
                  Card(
                    elevation: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(47, 14, 37, 27),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'What appointment are you going for',
                            style: TextStyle(
                              color: Color(0xFFC4C4C4),
                            ),
                          ),
                          TextField(
                            // Input for type of appointment
                            controller: _typeOfAppointmentController,
                          ),
                          SizedBox(
                            height: Config.yMargin(context, 2.43),
                          ),
                          Text(
                            'Write a note',
                            style: TextStyle(
                              color: Color(0xFFC4C4C4),
                            ),
                          ),
                          SizedBox(
                            height: Config.yMargin(context, 2.43),
                          ),
                          TextField(
                            //Input field for additional notes
                            controller: _noteController,
                            selectionHeightStyle: BoxHeightStyle.tight,
                            keyboardType: TextInputType.multiline,
                            maxLines: 9,
                            decoration: InputDecoration(
                                filled: true, border: OutlineInputBorder()),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Config.yMargin(context, 2),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(
                  left: Config.xMargin(context, 15),
                  right: Config.xMargin(context, 15),
                  bottom: Config.yMargin(context, 5),
                ),
                child: SizedBox(
                  width: width * 3,
                  child: RaisedButton(
                    color: appointmentReminder.selectedMonth != null &&
                            appointmentReminder.selectedDay != null &&
                            // appointmentReminder.selectedTime != null &&
                            appointmentReminder.typeOfAppointment != null &&
                            appointmentReminder.note != null
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.7),
                    padding: EdgeInsets.symmetric(
                        // horizontal: Config.xMargin(context, 10),
                        vertical: Config.yMargin(context, 2)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.03)),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: Config.textSize(context, 5.5),
                      ),
                    ),
                    // When this button is pressed, it saves the appointment to the DB
                    onPressed: appointmentReminder.selectedMonth != null &&
                            appointmentReminder.selectedDay != null &&
                            appointmentReminder.selectedTime != null &&
                            appointmentReminder.typeOfAppointment != null &&
                            appointmentReminder.note != null
                        ? () async {
                            appointmentReminder
                                .setSelectedNote(_noteController.text);
                            appointmentReminder.setSelectedTypeOfAppointment(
                                _typeOfAppointmentController.text);
                            if (appointmentReminder.selectedDay ==
                                    DateTime.now().day &&
                                appointmentReminder.selectedMonth ==
                                    DateTime.now().month) {
                              notificationManager
                                  .showAppointmentNotificationOnce(
                                      appointmentReminder.selectedDay,
                                      'Hey, you\' got somewhere to go',
                                      ' ${_typeOfAppointmentController.text} ',
                                      appointmentReminder.getDateTime());
                            }
                            appointmentReminderDB.addAppointment(
                                appointmentReminder.createSchedule());
                            Navigator.of(context).pop();
                            //here the function to save the schedule can be executed, by formatting the selected date as _today.year-selectedMonth-selectedDay i.e YYYY-MM-D
                          }
                        : null,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DateAndDay extends StatefulWidget {
  DateAndDay({this.colour, @required this.day, @required this.date});

  final Color colour;
  final String day;
  final String date;

  @override
  _DateAndDayState createState() => _DateAndDayState();
}

class _DateAndDayState extends State<DateAndDay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
//      onTap: () {
//        setState(() {
//          widget.colour = Theme.of(context).primaryColor;
//        });
//      },
      child: Container(
        child: Column(
          children: <Widget>[
            Text(
              widget.date,
              style: TextStyle(
                  fontSize: Config.textSize(context, 7.29),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              widget.day,
              style: TextStyle(
                  color: Color(0xFFC4C4C4),
                  fontSize: Config.textSize(context, 2.92)),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: Config.yMargin(context, 0.3),
              width: Config.xMargin(context, 9.24),
              decoration: BoxDecoration(
                color: widget.colour,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
