import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';

class MonthCount {
  String month;

  MonthCount({@required this.month});
}

List<MonthCount> monthValues = [
  MonthCount(month: 'January'),
  MonthCount(month: 'February'),
  MonthCount(month: 'March'),
  MonthCount(month: 'April'),
  MonthCount(month: 'May'),
  MonthCount(month: 'June'),
  MonthCount(month: 'July'),
  MonthCount(month: 'August'),
  MonthCount(month: 'September'),
  MonthCount(month: 'October'),
  MonthCount(month: 'November'),
  MonthCount(month: 'December'),
];

// Functions for the properties would be created and used in screen file
class ScheduleAppointmentModel extends ChangeNotifier {
  //Some static fields to load current month and prevent an error
  DateTime _today = DateTime.now();
  int _selectedDay;
  int _selectedMonth;
  String _selectedTime;
  String _typeOfAppointment;
  String _note;
  String selectedFreq = 'Once';
  List<Appointment> _availableAppointments = [];
  List<String> alertType = ['Once', 'Hourly', 'Daily', 'Weekly', 'Monthly'];

  List<DateTime> reminderDates = [];

  ScheduleAppointmentModel() {
    this._selectedMonth = _today.month;
    this._selectedDay = _today.day;
    this._selectedTime = null;
    this._typeOfAppointment = '';
    this._note = '';
  }

  String updateFrequency(String freq) {
    this.selectedFreq = freq;
    // switch (freq) {
    //   case 'Once':
    //     //logic
    //     break;
    //   case 'Hourly':
    //     //logic
    //     break;
    //   case 'Daily':
    //     //logic
    //     break;
    //   case 'Weekly':
    //     //logic
    //     break;
    //   case 'Monthly':
    //     //logic
    //     break;
    // }

    notifyListeners();
    return selectedFreq;
  }

  DateTime get today => _today;

  int get selectedDay => _selectedDay;

  setSelectedDay(int selectedDay) => _selectedDay = selectedDay;

  int get selectedMonth => _selectedMonth;

  setSelectedMonth(int selectedMonth) => _selectedMonth = selectedMonth;

  String get selectedTime => _selectedTime;

  setSelectedTime(dynamic selectedTime) => _selectedTime = selectedTime;

  String get typeOfAppointment => _typeOfAppointment;

  setSelectedTypeOfAppointment(String typeOfAppointment) =>
      _typeOfAppointment = typeOfAppointment;

  String get note => _note;

  setSelectedNote(String note) => _note = note;

  DateTime get selectedDateTime =>
      DateTime(_today.year, _selectedMonth, _selectedDay);

  void updateSelectedMonth(String val) {
    _selectedMonth =
        monthValues.indexWhere((element) => element.month == val) + 1;
    notifyListeners();
  }

  DateTime getDateTime() {
    String month = _selectedMonth.toString().length < 2
        ? '0$_selectedMonth'
        : '$_selectedMonth';
    String weekday =
        _selectedDay.toString().length < 2 ? '0$_selectedDay' : '$_selectedDay';
    return DateTime.parse(
        '${_today.year}-$month-$weekday ${_selectedTime.substring(0, 2)}:${_selectedTime.substring(3, 5)}');
  }

//
  Appointment createSchedule() {
    print(_selectedTime);
    var dayValue =
        selectedDay.toString().length < 2 ? '0$selectedDay' : '$selectedDay';
    var monthValue = selectedMonth.toString().length < 2
        ? '0$selectedMonth'
        : '$selectedMonth';

    var selectedDateTime = "${_today.year}-$monthValue-$dayValue";

    var appointmentType =
        _typeOfAppointment.toString().length < 1 ? '' : '$typeOfAppointment';

    var noteValue = _note.toString().length < 1 ? '' : '$note';

    Appointment newAppointment = Appointment(
        id: DateTime.now().toString(),
        date: DateTime.parse(selectedDateTime),
        appointmentType: appointmentType,
        note: noteValue,
        time: [
          num.parse(_selectedTime.substring(0, 2)),
          num.parse(_selectedTime.substring(3, 5))
        ],
        alertType: selectedFreq,
        reminderDates: reminderDates);
    return newAppointment;
  }

  Appointment editSchedule() {
    var dayValue =
        selectedDay.toString().length < 2 ? '0$selectedDay' : '$selectedDay';
    var monthValue = selectedMonth.toString().length < 2
        ? '0$selectedMonth'
        : '$selectedMonth';

    var selectedDateTime = "${_today.year}-$monthValue-$dayValue";

    var appointmentType =
        _typeOfAppointment.toString().length < 1 ? '' : '$typeOfAppointment';

    var noteValue = _note.toString().length < 1 ? '' : '$note';

    Appointment newAppointment = Appointment(
      id: DateTime.now().toString(),
      date: DateTime.parse(selectedDateTime),
      appointmentType: appointmentType,
      note: noteValue,
      time: [
        num.parse(_selectedTime.substring(1, 3)),
        num.parse(_selectedTime.substring(3, 5))
      ],
      alertType: selectedFreq,
      reminderDates: reminderDates,
    );
    return newAppointment;
  }

  void updateSelectedDay(int dayIndex) {
    _selectedDay = dayIndex + 1;
    notifyListeners();
  }

  void updateSelectedTime(String time) {
    _selectedTime = time;
    //notifyListeners();
  }

  void updateReminderDates(reminderDatess) {
    reminderDates = reminderDatess;
    notifyListeners();
  }

  void updateAvailableAppointmentReminder(appointmentReminder) {
    _availableAppointments.clear();
    _availableAppointments = appointmentReminder;
    notifyListeners();
  }

  List<Appointment> get pastApointments {
    List<Appointment> appointments = [];
    //2020-07-16 00:30:48.163023

    // DateTime newDate = DateTime.parse(
    //     '${selectedDateTime.year}-$month-$day ${selectedTime.substring(1, 2)}:${selectedTime.substring(3, 5)}');
    // print(newDate);
    // return _availableAppointments
    //     .where((appointment) => selectedDateTime.day > appointment.date.day)
    //     .toList();
    _availableAppointments.forEach((appointment) {
      String month = '${appointment.date.month}'.trim().length == 1
          ? '0${appointment.date.month}'
          : '${appointment.date.month}';
      String day = '${appointment.date.day}'.trim().length == 1
          ? '0${appointment.date.day}'
          : '${appointment.date.day}';
      String hour = '${appointment.time[0]}'.trim().length == 1
          ? '0${appointment.time[0]}'
          : '${appointment.time[0]}';
      String minutes = '${appointment.time[1]}'.trim().length == 1
          ? '0${appointment.time[1]}'
          : '${appointment.time[1]}';

      DateTime newDate =
          DateTime.parse('${appointment.date.year}-$month-$day $hour:$minutes');
      if (newDate.isBefore(DateTime.now())) {
        appointments.add(appointment);
      }
    });
    return appointments;
  }

  List<Appointment> get upcomingApointments {
    List<Appointment> appointments = [];

    //2020-07-16 00:30:48.163023

    // DateTime newDate = DateTime.parse(

    //     '${selectedDateTime.year}-$month-$day ${selectedTime.substring(1, 2)}:${selectedTime.substring(3, 5)}');

    // print(newDate);

    // return _availableAppointments

    //     .where((appointment) => selectedDateTime.day > appointment.date.day)

    //     .toList();

    _availableAppointments.forEach((appointment) {
      String month = '${appointment.date.month}'.trim().length == 1
          ? '0${appointment.date.month}'
          : '${appointment.date.month}';

      String day = '${appointment.date.day}'.trim().length == 1
          ? '0${appointment.date.day}'
          : '${appointment.date.day}';

      String hour = '${appointment.time[0]}'.trim().length == 1
          ? '0${appointment.time[0]}'
          : '${appointment.time[0]}';

      String minutes = '${appointment.time[1]}'.trim().length == 1
          ? '0${appointment.time[1]}'
          : '${appointment.time[1]}';

      DateTime newDate =
          DateTime.parse('${appointment.date.year}-$month-$day $hour:$minutes');

      //print(newDate);

      if (newDate.isAfter(DateTime.now())) {
        appointments.add(appointment);
      }
    });

    return appointments;
  }

  List<Appointment> get allAppointments {
    return _availableAppointments;
  }

  bool isActive(index) {
    //increment index to match day index and compare
    return index + 1 == _selectedDay;
  }

  String get currentMonth {
    return monthValues[_today.month - 1].month;
  }

  String get selectedMonthValue {
    return monthValues[_today.month - 1].month;
  }

//  List<Appointment> get appointmentRemindersBasedOnDateTime{
//    return _availableAppointments.where((reminder) => selectedDateTime.day == reminder.dateTime.day).toList();
//  }

  getWeekDay(index) {
    //increment index to match month index
    index++;
    int year = _today.year;
    //check for single digit months e.g. 1,2,3 to format to 01,02,03 strings
    String month = _selectedMonth.toString().length < 2
        ? '0$_selectedMonth'
        : '$_selectedMonth';
    String weekday = index.toString().length < 2 ? '0$index' : '$index';
    //formats date to format of 2020-06-20 i.e. YYYY-MM-DD
    String val = DateFormat.E().format(
      DateTime.parse('$year' + '-' + '$month' + '-' + '$weekday'),
    );

    return val;
  }

  int get daysInMonth {
    return DateUtil().daysInMonth(_selectedMonth, _today.year);
  }

  Color getButtonColor(BuildContext context, index) {
    return isActive(index)
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColorDark.withOpacity(0.05);
  }

  TextStyle calendarTextStyle(BuildContext context, index) {
    return TextStyle(
      color: Colors.white,
      fontSize: Config.textSize(context, 6),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle calendarSubTextStyle(BuildContext context, index) {
    return TextStyle(
      color: Colors.white,
      fontSize: Config.textSize(context, 5),
      fontWeight: FontWeight.normal,
    );

    // int get userSelectedDay => selectedDay;
    // setSelectedDay(int userSelectedDay) => selectedDay = userSelectedDay;

    // int get userSelectedMonth => selectedMonth;
    // setSelectedMonth(int userSelectedMonth) => selectedMonth = userSelectedMonth;

    // dynamic get userSelectedTime => selectedTime;
    // setSelectedTime(dynamic userSelectedTime) => selectedTime = userSelectedTime;
  }
}
