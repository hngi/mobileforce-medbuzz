import 'package:MedBuzz/core/models/water_reminder.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class MonthCount {
  String month;
  // int days;

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

class AllRemindersViewModel extends ChangeNotifier {
  DateTime _today = DateTime.now();
  int _selectedMl;
  int _selectedDay;
  int _selectedMonth;
  dynamic _selectedTime;

  AllRemindersViewModel() {
    this._selectedMl = null;
    this._selectedMonth = _today.month;
    this._selectedDay = _today.day;
    this._selectedTime = null;
  }

  int get selectedDay => _selectedDay;
  setSelectedDay(int selectedDay) => _selectedDay = selectedDay;

  int get selectedMonth => _selectedMonth;
  setSelectedMonth(int selectedMonth) => _selectedMonth = selectedMonth;

  dynamic get selectedTime => _selectedTime;
  setSelectedTime(dynamic selectedTime) => _selectedTime = selectedTime;

  Color getButtonColor(BuildContext context, index) {
    return isActive(index)
        ? Theme.of(context).buttonColor
        : Theme.of(context).primaryColorDark.withOpacity(0.05);
  }

  TextStyle calendarTextStyle(BuildContext context, index) {
    return TextStyle(
      color: isActive(index)
          ? Theme.of(context).primaryColorLight
          : Theme.of(context).primaryColorDark,
      fontSize: Config.textSize(context, 9),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle calendarMonthTextStyle(BuildContext context, index) {
    return TextStyle(
      color: _selectedMonth == index
          ? Theme.of(context).primaryColor
          : Theme.of(context).primaryColorDark,
      fontSize: Config.textSize(context, 4),
      fontWeight: FontWeight.bold,

    );
  }

  TextStyle calendarSubTextStyle(BuildContext context, index) {
    return TextStyle(
      color: isActive(index)
          ? Theme.of(context).primaryColorLight
          : Theme.of(context).primaryColorDark,
      fontSize: Config.textSize(context, 4),
      fontWeight: FontWeight.normal,
    );
  }

  void updateSelectedMonth(String val) {
    _selectedMonth =
        monthValues.indexWhere((element) => element.month == val) ;
    notifyListeners();
  }

  void updateSelectedDay(int dayIndex) {
    _selectedDay = dayIndex + 1;
    notifyListeners();
  }

  void updateSelectedTime(dynamic time) {
    _selectedTime = time;
    // notifyListeners();
  }

  bool isActive(index) {
    //increment index to match day index and compare
    return index + 1 == _selectedDay;
  }

  String get currentMonth {
    return monthValues[_selectedMonth - 1].month;
  }

  String get selectedMonthValue {
    return monthValues[_today.month - 1].month;
  }

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
}
