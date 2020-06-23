import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Month{
  String month;
  Month({this.month});
}

class FitnessSchedulesModel extends ChangeNotifier {
  bool _isVisible = true;
  DateTime _selectedDay = DateTime.now();

  bool get isVisible => _isVisible;

//functionality for making the FAB appear and disappear when user scrolls
  void updateVisibility(bool visible) {
    this._isVisible = visible;
    notifyListeners();
  }

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

//Button color for selected day is different from others
//Selected day is DateTime.now().day by default
  Color getButtonColor(BuildContext context, DateTime date) {
    return date.day == _selectedDay.day
        ? Theme.of(context).buttonColor
        : Colors.grey[200];
  }

//Text color changes depending on the button color
  Color getTextColor(BuildContext context, DateTime date) {
    return date.day == _selectedDay.day
        ? Theme.of(context).primaryColorLight
        : Theme.of(context).primaryColorDark;
  }

//Toggles date displayed on the screen
  void changeDay(DateTime date) {
    this._selectedDay = date;
    notifyListeners();
  }
}
