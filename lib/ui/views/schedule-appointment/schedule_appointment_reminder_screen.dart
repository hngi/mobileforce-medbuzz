import 'dart:ui';
import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/database/appointmentData.dart';
import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:MedBuzz/core/notifications/appointment_notification_manager.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/widget/appBar.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../size_config/config.dart';
import 'package:MedBuzz/ui/widget/time_wheel.dart';
import 'schedule_appointment_screen_model.dart';
import 'package:MedBuzz/ui/widget/snack_bar.dart';

class ScheduleAppointmentScreen extends StatelessWidget {
  static const routeName = 'schedule-appointment-reminder';
  final String payload;
  final Appointment appointment;
  final String buttonText;
  ScheduleAppointmentScreen({
    Key key,
    this.payload,
    this.appointment,
    this.buttonText = "Save",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MyScheduleAppointmentScreen(
      payload: payload,
      appointment: appointment,
      buttonText: buttonText,
    ));
  }
}

class MyScheduleAppointmentScreen extends StatefulWidget {
  static const routeName = 'schedule-appointment-reminder';
  final String payload;
  final Appointment appointment;
  final String buttonText;

  MyScheduleAppointmentScreen(
      {Key key, this.payload, this.appointment, this.buttonText})
      : super(key: key);

  @override
  _MyScheduleAppointmentScreenState createState() =>
      _MyScheduleAppointmentScreenState();
}

class _MyScheduleAppointmentScreenState
    extends State<MyScheduleAppointmentScreen> {
  final ItemScrollController _scrollController = ItemScrollController();

  TextEditingController _typeOfAppointmentController = TextEditingController();

  TextEditingController _noteController = TextEditingController();

  List<DateTime> reminderDates = [];
  String alertType;

  ScheduleAppointmentModel appointmentModel = ScheduleAppointmentModel();

  String _updateMonth;
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    _updateMonth = appointmentModel.currentMonth;

    myFocusNode = FocusNode();
    if (widget.buttonText == 'Update') {
      alertType = widget.appointment.alertType;
      reminderDates = widget.appointment.reminderDates ?? [];
      _typeOfAppointmentController.text =
          widget.appointment.appointmentType ?? '';
      _noteController.text = widget.appointment.note ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appointmentReminder =
        Provider.of<ScheduleAppointmentModel>(context, listen: true);

    var appointmentReminderDB =
        Provider.of<AppointmentData>(context, listen: true);

    // appointmentReminderDB.getAppointments();
    AppointmentNotificationManager notificationManager =
        AppointmentNotificationManager();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appointmentReminder.updateAvailableAppointmentReminder(
          appointmentReminderDB.appointment);
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Color bgColor = Theme.of(context).backgroundColor;

    return Scaffold(
      appBar: appBar(
          context: context,
          title: 'Add your appointment',
          onPressed: () {
            // Navigator.pushReplacementNamed(context, RouteNames.homePage);
            Navigator.pop(context);
          }),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Config.xMargin(context, 35.0)),
                child: DropdownButtonHideUnderline(
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
                                      color:
                                          Theme.of(context).primaryColorDark),
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
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Config.xMargin(context, 6.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Alert Type',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //fontSize: Config.textSize(context, 4),
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: Config.yMargin(context, 1),
                    ),
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).primaryColorLight,
                            hintText: '${appointmentModel.alertType}',
                            hintStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: Config.xMargin(context, 4),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  Config.xMargin(context, 5),
                                ),
                              ),
                            ),
                          ),
                          isEmpty: false,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: Config.xMargin(context, 8),
                              ),
                              value: alertType,
                              //appointmentModel.selectedFreq,
                              isDense: true,
                              onChanged: (String newValue) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                setState(() {
                                  alertType = newValue;
                                  state.didChange(newValue);
                                });
                                appointmentModel.updateFrequency(newValue);
                              },
                              items: appointmentModel.alertType
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: Config.textSize(context, 4)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: Config.yMargin(context, 2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Add Reminder Dates',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            //fontSize: Config.textSize(context, 4.8),
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () async {
                            final DateTime selectedDate = await showDatePicker(
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(DateTime.now().year + 1),
                              context: context,
                              initialDate: DateTime.now(),
                            );
                            if (selectedDate != null)
                              reminderDates.add(selectedDate);
                          },
                        ),
                      ],
                    ),
                    if (reminderDates != null)
                      for (var appointment in reminderDates)
                        Container(
                          margin: EdgeInsets.only(
                              bottom: Config.yMargin(context, 1)),
                          padding: EdgeInsets.symmetric(
                              horizontal: Config.xMargin(context, 5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                DateFormat.yMMMMd().format(appointment),
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ),
                                onPressed: () =>
                                    reminderDates.remove(appointment),
                              )
                            ],
                          ),
                          height: Config.yMargin(context, 7),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  Config.xMargin(context, 5),
                                ),
                              ),
                              color: Theme.of(context).primaryColorLight),
                        ),
                  ],
                ),
              ),
              SizedBox(
                height: Config.yMargin(context, 3),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Appointment Time',
                    style: TextStyle(
                        fontSize: Config.textSize(context, 4.0),
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.w600),
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
                            focusNode: myFocusNode,
                            autofocus: true,
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
                            autofocus: true,
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
                            appointmentReminder.selectedTime != null &&
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
                      widget.buttonText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Config.textSize(context, 5.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // When this button is pressed, it saves the appointment to the DB
                    onPressed: appointmentReminder.selectedMonth != null &&
                            appointmentReminder.selectedDay != null &&
                            appointmentReminder.selectedTime != null &&
                            appointmentReminder.typeOfAppointment != null &&
                            appointmentReminder.note != null
                        ? () async {
                            for (var appointment in reminderDates)
                              notificationManager.showAppointmentNotificationOnce(
                                  appointment.millisecond,
                                  'Your Appointment Reminder',
                                  'Just wanted to remind you about your appointment: ${_typeOfAppointmentController.text}',
                                  appointment);
                            switch (appointmentModel.selectedFreq) {
                              case 'Hourly':
                                notificationManager
                                    .showAppointmentAtSpecifiedInterval(
                                        id: DateTime.now().millisecond,
                                        title: 'Appointment Reminder',
                                        body:
                                            'Just a reminder for your upcoming appointment: ${_typeOfAppointmentController.text}',
                                        interval: RepeatInterval.Hourly);
                                break;
                            }
                            switch (appointmentModel.selectedFreq) {
                              case 'Daily':
                                notificationManager
                                    .showAppointmentAtSpecifiedInterval(
                                  id: DateTime.now().millisecond,
                                  title: 'Appointment Reminder',
                                  body:
                                      'Just a reminder for your upcoming appointment: ${_typeOfAppointmentController.text}',
                                  interval: RepeatInterval.Daily,
                                );
                                break;
                            }
                            switch (appointmentModel.selectedFreq) {
                              case 'Weekly':
                                notificationManager
                                    .showAppointmentAtSpecifiedInterval(
                                  id: DateTime.now().millisecond,
                                  title: 'Appointment Reminder',
                                  body:
                                      'Just a reminder for your upcoming appointment: ${_typeOfAppointmentController.text}',
                                  interval: RepeatInterval.Weekly,
                                );
                                break;
                            }
                            switch (widget.buttonText) {
                              case 'Save':
                                try {
                                  DateTime selected =
                                      appointmentReminder.getDateTime();
                                  DateTime now = DateTime.now();
                                  String month =
                                      '${selected.month}'.trim().length == 1
                                          ? '0${selected.month}'
                                          : '${selected.month}';
                                  String day =
                                      '${selected.day}'.trim().length == 1
                                          ? '0${selected.day}'
                                          : '${selected.day}';
                                  String hour =
                                      '${appointmentReminder.selectedTime.substring(0, 2)}'
                                                  .trim()
                                                  .length ==
                                              1
                                          ? '0${appointmentReminder.selectedTime.substring(0, 2)}'
                                          : '${appointmentReminder.selectedTime.substring(0, 2)}';
                                  String minutes =
                                      '${appointmentReminder.selectedTime.substring(3, 5)}'
                                                  .trim()
                                                  .length ==
                                              1
                                          ? '0${appointmentReminder.selectedTime.substring(3, 5)}'
                                          : '${appointmentReminder.selectedTime.substring(3, 5)}';

                                  DateTime currentTime = DateTime.parse(
                                      '${now.year}-$month-$day $hour:$minutes');
                                  print(_typeOfAppointmentController.text);
                                  if (currentTime.isBefore(now)) {
                                    CustomSnackBar.showSnackBar(context,
                                        text:
                                            'Reminder cannot be set in the past');
                                    return;
                                  }
                                  if (_typeOfAppointmentController
                                      .text.isNotEmpty) {
                                    appointmentReminder.setSelectedNote(
                                        _noteController.text ?? '');
                                    appointmentReminder
                                        .updateFrequency(alertType);
                                    appointmentReminder
                                        .updateReminderDates(reminderDates);
                                    appointmentReminder
                                        .setSelectedTypeOfAppointment(
                                            _typeOfAppointmentController.text);

                                    await appointmentReminderDB.addAppointment(
                                        appointmentReminder.createSchedule());
                                    print(appointmentReminder.reminderDates
                                        .toList());

                                    // if (appointmentReminder.selectedDay ==
                                    //         DateTime.now().day &&
                                    //     appointmentReminder.selectedMonth ==
                                    //         DateTime.now().month)
                                    String time =
                                        appointmentReminder.selectedTime;
                                    String hour = time.substring(0, 2);
                                    String minutes = time.substring(3, 5);
                                    DateTime now = DateTime.now();
                                    String id =
                                        '${now.year}${now.month}${now.day}$hour$minutes';
                                    String notifId = id.length < 11
                                        ? id
                                        : id.substring(0, 10);
                                    notificationManager
                                        .showAppointmentNotificationOnce(
                                            num.parse(notifId),
                                            'Hey, you\'ve got somewhere to go',
                                            ' ${_typeOfAppointmentController.text} ',
                                            appointmentReminder.getDateTime());

                                    Navigator.popAndPushNamed(
                                        context, RouteNames.homePage);
                                  } else {
                                    CustomSnackBar.showSnackBar(context);
                                    return;
                                  }
                                } catch (e) {
                                  print(e);
                                }
                                break;
                              case 'Update':
                                print(_typeOfAppointmentController.text);
                                DateTime selected =
                                    appointmentReminder.getDateTime();
                                DateTime now = DateTime.now();
                                String month =
                                    '${selected.month}'.trim().length == 1
                                        ? '0${selected.month}'
                                        : '${selected.month}';
                                String day =
                                    '${selected.day}'.trim().length == 1
                                        ? '0${selected.day}'
                                        : '${selected.day}';
                                String hour =
                                    '${appointmentReminder.selectedTime.substring(0, 2)}'
                                                .trim()
                                                .length ==
                                            1
                                        ? '0${appointmentReminder.selectedTime.substring(0, 2)}'
                                        : '${appointmentReminder.selectedTime.substring(0, 2)}';
                                String minutes =
                                    '${appointmentReminder.selectedTime.substring(3, 5)}'
                                                .trim()
                                                .length ==
                                            1
                                        ? '0${appointmentReminder.selectedTime.substring(3, 5)}'
                                        : '${appointmentReminder.selectedTime.substring(3, 5)}';

                                DateTime currentTime = DateTime.parse(
                                    '${now.year}-$month-$day $hour:$minutes');
                                if (currentTime.isBefore(now)) {
                                  CustomSnackBar.showSnackBar(context,
                                      text:
                                          'Reminder cannot be set in the past');
                                  return;
                                }
                                if (_typeOfAppointmentController
                                    .text.isNotEmpty) {
                                  appointmentReminder.setSelectedNote(
                                      _noteController.text ?? '');
                                  appointmentReminder
                                      .updateReminderDates(reminderDates);
                                  appointmentReminder
                                      .updateFrequency(alertType);
                                  appointmentReminder
                                      .setSelectedTypeOfAppointment(
                                          _typeOfAppointmentController.text);

                                  await appointmentReminderDB.editAppointment(
                                      appointment:
                                          appointmentReminder.createSchedule());

                                  if (appointmentReminder.selectedDay ==
                                          DateTime.now().day &&
                                      appointmentReminder.selectedMonth ==
                                          DateTime.now().month) {
                                    String time =
                                        appointmentReminder.selectedTime;
                                    String hour = time.substring(1, 2);
                                    String minutes = time.substring(3, 5);
                                    DateTime now = DateTime.now();
                                    print(now);
                                    notificationManager
                                        .showAppointmentNotificationOnce(
                                            num.parse(
                                                '${now.year}${now.month}${now.day}$hour$minutes'),
                                            'Hey, you\'ve got somewhere to go',
                                            '${_typeOfAppointmentController.text}',
                                            appointmentReminder.getDateTime());
                                  }
                                }
                                break;
                            }
                            Navigator.popAndPushNamed(
                                context, RouteNames.homePage);
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
