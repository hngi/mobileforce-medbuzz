import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/models/water_reminder_model/water_reminder.dart';

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

class ScheduleWaterReminderViewModel extends ChangeNotifier {
  List<int> _mls = [150, 250, 350, 500, 750, 1000];
  DateTime _today = DateTime.now();
  int _selectedMl;
  int _selectedInterval = 30;
  int _selectedDay;
  int _selectedMonth;
  dynamic _selectedStartTime;
  dynamic _selectedEndTime;
  String _description = '';
  List<WaterReminder> _availableReminders = [];

  ScheduleWaterReminderViewModel() {
    this._selectedMl = null;
    this._selectedMonth = _today.month;
    this._selectedDay = _today.day;
    this._selectedStartTime = null;
  }

  getMesures() => _mls;
  DateTime get today => _today;

  int get selectedMl => _selectedMl;

  int get selectedDay => _selectedDay;

  int get selectedMonth => _selectedMonth;

  String get description => _description;

  int get selectedInterval => _selectedInterval;

  List<int> get mls => _mls;
  List<WaterReminder> get availableReminders => _availableReminders;

  dynamic get selectedStartTime => _selectedStartTime;
  dynamic get selectedEndTime => _selectedEndTime;

  DateTime get selectedDateTime =>
      DateTime(_today.year, _selectedMonth, _selectedDay);

  Color getButtonColor(BuildContext context, index) {
    return isActive(index)
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColorDark.withOpacity(0.05);
  }

  Color getGridItemColor(BuildContext context, ml) {
    return isSelectedMl(ml)
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColorLight;
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

  TextStyle gridItemTextStyle(BuildContext context, ml) {
    return TextStyle(
        fontSize: Config.textSize(context, 5),
        fontWeight: FontWeight.w500,
        color: isSelectedMl(ml) ? Colors.white : Colors.black);
  }

  void updateSelectedMonth(String val) {
    _selectedMonth =
        monthValues.indexWhere((element) => element.month == val) + 1;
    notifyListeners();
  }

  void updateSelectedInterval(int val) {
    _selectedInterval = val;
    notifyListeners();
  }

  void updateDescription(String val) {
    _description = val;
    notifyListeners();
  }

  WaterReminder createSchedule() {
    // var dayValue =
    //     selectedDay.toString().length < 2 ? '0$selectedDay' : '$selectedDay';
    // var monthValue = selectedMonth.toString().length < 2
    //     ? '0$selectedMonth'
    //     : '$selectedMonth';
    // var selectedDateTime =
    //     "${_today.year}-$monthValue-$dayValue $selectedStartTime";

    WaterReminder newReminder = WaterReminder(
        id: DateTime.now().toString(),
        ml: _selectedMl,
        interval: _selectedInterval,
        description: _description,
        startTime: getDateTime(),
        endTime: getEndDateTime());
    // print(newReminder);
    return newReminder;
  }

  DateTime getDateTime() {
    String month = _selectedMonth.toString().length < 2
        ? '0$_selectedMonth'
        : '$_selectedMonth';
    String weekday =
        _selectedDay.toString().length < 2 ? '0$_selectedDay' : '$_selectedDay';
    return DateTime.parse('${_today.year}-$month-$weekday $_selectedStartTime');
  }

  DateTime getEndDateTime() {
    String month = _selectedMonth.toString().length < 2
        ? '0$_selectedMonth'
        : '$_selectedMonth';
    String weekday =
        _selectedDay.toString().length < 2 ? '0$_selectedDay' : '$_selectedDay';
    return DateTime.parse('${_today.year}-$month-$weekday $_selectedEndTime');
  }

  void updateSelectedDay(int dayIndex) {
    _selectedDay = dayIndex + 1;
    notifyListeners();
  }

  void updateSelectedTime(dynamic time) {
    _selectedStartTime = time;
    // notifyListeners();
  }

  void updateSelectedStartTime(dynamic time) {
    _selectedStartTime = time;
    // notifyListeners();
  }

  void updateSelectedEndTime(dynamic time) {
    _selectedEndTime = time;
    // notifyListeners();
  }

  void updateSelectedMl(ml) {
    _selectedMl = ml;
    notifyListeners();
  }

  void updateAvailableReminders(waterReminders) {
    _availableReminders = waterReminders;
    notifyListeners();
  }

  bool isActive(index) {
    //increment index to match day index and compare
    return index + 1 == _selectedDay;
  }

  bool isSelectedMl(ml) {
    return _selectedMl == ml;
  }

  String get currentMonth {
    return monthValues[_selectedMonth - 1].month;
  }

  String get selectedMonthValue {
    return monthValues[_today.month - 1].month;
  }

  List<WaterReminder> get waterRemindersBasedOnDateTime {
    return _availableReminders
        .where((reminder) => selectedDateTime.year == reminder.startTime.year)
        .toList();
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
