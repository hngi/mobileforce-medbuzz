import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicationsSchedulesModel extends ChangeNotifier {
  int selectedDay = DateTime.now().day;
  static DateTime today = DateTime.now();
  static int month = today.month;
  String selectedMonth = months[month - 1] + '-' + '2020';
  bool isVisible = true;
  bool isExpanded = false;
  DateTime _selectedDay = DateTime.now();
  List<MedicationReminder> _availableMedicationReminders = [];

  static List<String> months = [
    'JANUARY',
    'FEBURARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER'
  ];

  //functionality for making the FAB appear and disappear when user scrolls
  void updateVisibility(bool visible) {
    this.isVisible = visible;
    notifyListeners();
  }

  void expandTile(bool changed) {
    this.isExpanded = !isExpanded;
    notifyListeners();
  }

  void updateSelectedDay(int dayIndex) {
    selectedDay = dayIndex + 1;
    notifyListeners();
  }

  void updateAvailableMedicationReminders(
      List<MedicationReminder> medicationReminders) {
    _availableMedicationReminders = medicationReminders;
    notifyListeners();
  }

  List<MedicationReminder> get medicationReminderBasedOnDateTime {
    return _availableMedicationReminders
        .where((medication) =>
            selectedDay >= medication.startAt.day &&
            selectedDay <= medication.endAt.day)
        .toList();
  }

  bool isActive(index) {
    //increment index to match day index and compare
    return index + 1 == selectedDay;
  }

  int daysInMonth = DateUtil().daysInMonth(month, today.year);

  //Retrieve data from DB

  //Get name of weekday
  String getWeekday(DateTime date) {
    return date.weekday == 1
        ? 'Mon'
        : date.weekday == 2
            ? 'Tue'
            : date.weekday == 3
                ? 'Wed'
                : date.weekday == 4
                    ? 'Thur'
                    : date.weekday == 5
                        ? 'Fri'
                        : date.weekday == 6 ? 'Sat' : 'Sun';
  }

  getWeekDay(index) {
    //increment index to match month index
    index++;
    int year = today.year;
    //check for single digit months e.g. 1,2,3 to format to 01,02,03 strings
    String monthh = month.toString().length < 2 ? '0$month' : '$month';
    String weekday = index.toString().length < 2 ? '0$index' : '$index';
    //formats date to format of 2020-06-20 i.e. YYYY-MM-DD
    String val = DateFormat.E().format(
      DateTime.parse('$year' + '-' + '$monthh' + '-' + '$weekday'),
    );

    return val;
  }

  //Button color for selected day is different from others
//Selected day is DateTime.now().day by default
  // Color getButtonColor(BuildContext context, DateTime date) {
  //   return date.day == _selectedDay.day
  //       ? Theme.of(context).buttonColor
  //       : Colors.grey[200];
  // }

  Color getButtonColor(BuildContext context, index) {
    return isActive(index)
        ? Theme.of(context).buttonColor
        : Theme.of(context).primaryColorDark.withOpacity(0.05);
  }

  //Text color changes depending on the button color
  Color getTextColor(BuildContext context, index) {
    return isActive(index)
        ? Theme.of(context).primaryColorLight
        : Theme.of(context).primaryColorDark;
  }

  TextStyle calendarMonthTextStyle(BuildContext context, index) {
    return TextStyle(
      color: isActive(index)
          ? Theme.of(context).primaryColorLight
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

  //Toggles date displayed on the screen
  void changeDay(DateTime date) {
    this._selectedDay = date;
    notifyListeners();
  }
}
