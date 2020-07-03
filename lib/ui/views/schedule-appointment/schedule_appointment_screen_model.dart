import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

// Functions for the properties would be created and used in screen file
class ScheduleAppointmentModel extends ChangeNotifier {
  //Some static fields to load current month and prevent an error
  static DateTime __today = DateTime.now();
  static int __month = __today.month;
  DateTime today = DateTime.now();
  //int selectedDay;
  int selectedMonth;
  dynamic selectedTime;
  String typeOfAppointment;
  String note;

  static List<String> _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  int _selectedDay = DateTime.now().day;
  DateTime _today = DateTime.now();
  int _month = __today.month;
  int _daysInMonth = DateUtil().daysInMonth(__month, __today.year);
  String _selectedMonth = _months[__month - 1];

  int get selectedDay => _selectedDay;
  int get daysInMonth => _daysInMonth;

  void updateSelectedDay(int dayIndex) {
    _selectedDay = dayIndex + 1;
    notifyListeners();
  }

  getWeekDay(index) {
    //increment index to match month index
    index++;
    int year = _today.year;
    //check for single digit months e.g. 1,2,3 to format to 01,02,03 strings
    String month = _month.toString().length < 2 ? '0$_month' : '$_month';
    String weekday = index.toString().length < 2 ? '0$index' : '$index';
    //formats date to format of 2020-06-20 i.e. YYYY-MM-DD
    String val = DateFormat.E().format(
      DateTime.parse('$year' + '-' + '$month' + '-' + '$weekday'),
    );

    return val;
  }

  List<String> get months => _months;
  String get currentMonthSelected => _selectedMonth;

  void updateSelectedTime(dynamic time) {
    selectedTime = time;
  }

  void updateSelectedMonth(String newMonth) {
    this._selectedMonth = newMonth;
    notifyListeners();
  }

  // int get userSelectedDay => selectedDay;
  // setSelectedDay(int userSelectedDay) => selectedDay = userSelectedDay;

  // int get userSelectedMonth => selectedMonth;
  // setSelectedMonth(int userSelectedMonth) => selectedMonth = userSelectedMonth;

  // dynamic get userSelectedTime => selectedTime;
  // setSelectedTime(dynamic userSelectedTime) => selectedTime = userSelectedTime;
}
