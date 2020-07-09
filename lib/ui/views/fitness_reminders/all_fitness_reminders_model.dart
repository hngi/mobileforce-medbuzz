import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Month {
  String month;
  Month({this.month});
}

class FitnessSchedulesModel extends ChangeNotifier {
  //Some static fields to load current month and prevent an error
  static DateTime __today = DateTime.now();
  static int __month = __today.month;
  bool _isVisible = true;
  int _month = __today.month;
  String _selectedMonth = _months[__month - 1];
  dynamic _selectedTime;
  String name;
  int _selectedDay = DateTime.now().day;
  DateTime _today = DateTime.now();
  int _daysInMonth = DateUtil().daysInMonth(__month, __today.year);

  static List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<String> get months => _months;
  int get selectedDay => _selectedDay;
  String get currentMonth => _selectedMonth;
  int get daysInMonth => _daysInMonth;
  dynamic get selectedTime => _selectedTime;
  bool get isVisible => _isVisible;

  void getDaysInMonth() {
    this._daysInMonth = DateUtil().daysInMonth(_month, _today.year);
    notifyListeners();
  }

//functionality for making the FAB appear and disappear when user scrolls
  void updateVisibility(bool visible) {
    this._isVisible = visible;
    notifyListeners();
  }

  //Retrieve data from DB

  //Get name of weekday
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

  void updateSelectedDay(int dayIndex) {
    _selectedDay = dayIndex + 1;
    notifyListeners();
  }

  bool isActive(index) {
    //increment index to match day index and compare
    return index + 1 == _selectedDay;
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
  }

//Text color changes depending on the button color
  Color getTextColor(BuildContext context, DateTime date) {
    return date.day == _selectedDay
        ? Theme.of(context).primaryColorLight
        : Theme.of(context).primaryColorDark;
  }

// //Toggles date displayed on the screen
//   void changeDay(DateTime date) {
//     this._selectedDay = date;
//     notifyListeners();
//   }
}
