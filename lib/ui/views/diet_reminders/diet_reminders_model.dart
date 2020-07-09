import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//El oh El A lot of magic happened here that I did not document
class DietReminderModel extends ChangeNotifier {
  //Some static fields to load current month and prevent an error
  static DateTime __today = DateTime.now();
  static int __month = __today.month;

  List<String> _selectedFoodClasses = [];

  int _currentDay = DateTime.now().day;
  String _selectedFoodClass;
  bool _isProtein = false;
  bool _isCarb = false;
  bool _isVegetable = false;
  bool _isFruit = false;
  bool _isDrink = false;
  int _month = __today.month;
  String _selectedMonth = _months[__month - 1];
  dynamic _selectedTime;
  int _selectedDay = DateTime.now().day;
  DateTime _today = DateTime.now();
  int _daysInMonth = DateUtil().daysInMonth(__month, __today.year);

  int get currentDay => _currentDay;
  List<String> get selectedFoodClasses => _selectedFoodClasses;

  int get month => _month;

  DateTime getSelectedDate() =>
      DateTime.parse('${__today.year}-$_month-$_selectedDay');

  //this function is used on the AllDietReminders screen to convert the foodclasses
  //retrieved from the diet model from list to string
  String foodClassesFromDietModel(List<String> list) {
    if (list.length == 1) {
      return list[0];
    }
    String str = '';
    for (var i in list) {
      if (i == list[list.length - 1]) {
        str += ' and $i.';
      } else {
        str += '$i,';
      }
    }
    return str;
  }

  //this function is used on the AllDietReminders screen to convert the month
  //retrieved from the date of the reminder from int to string
  String monthFromInt(int month) {
    return month == 1
        ? 'January'
        : month == 2
            ? 'February'
            : month == 3
                ? 'March'
                : month == 4
                    ? 'April'
                    : month == 5
                        ? 'May'
                        : month == 6
                            ? 'June'
                            : month == 7
                                ? 'July'
                                : month == 8
                                    ? 'August'
                                    : month == 9
                                        ? 'September'
                                        : month == 10
                                            ? 'October'
                                            : month == 11
                                                ? 'November'
                                                : 'December';
  }

  //this function is used on the AllDietReminders screen to convert the weekday
  //retrieved from the date of the reminder from int to string

  String weekayFromInt(int weekday) {
    return weekday == 1
        ? 'Mon'
        : weekday == 2
            ? 'Tue'
            : weekday == 3
                ? 'Wed'
                : weekday == 4
                    ? 'Thur'
                    : weekday == 5 ? 'Fri' : weekday == 6 ? 'Sat' : 'Sun';
  }

  DateTime getStartDate() {
    String month = _month.toString().length < 2 ? '0$_month' : '$_month';
    String weekday =
        _selectedDay.toString().length < 2 ? '0$_selectedDay' : '$_selectedDay';
    return DateTime.parse('${__today.year}-$month-$weekday');
  }

  DateTime getDateTime() {
    String month = _month.toString().length < 2 ? '0$_month' : '$_month';
    String weekday =
        _selectedDay.toString().length < 2 ? '0$_selectedDay' : '$_selectedDay';
    return DateTime.parse(
        '${__today.year}-$month-$weekday ${_selectedTime.substring(0, 2)}:${selectedTime.substring(3, 5)}');
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

  void updatesSelectedFoodClasses(String foodClass) {
    if (_selectedFoodClasses.contains(foodClass)) {
      this._selectedFoodClasses.remove(foodClass);
      notifyListeners();
      return;
    }
    if (!_selectedFoodClasses.contains(foodClass)) {
      this._selectedFoodClasses.add(foodClass);
      notifyListeners();
      return;
    }
  }

  void getDaysInMonth() {
    this._daysInMonth = DateUtil().daysInMonth(_month, _today.year);
    notifyListeners();
  }

  List<FoodClass> _foodClass = [
    FoodClass(name: 'Protein', image: 'images/protein.png'),
    FoodClass(name: 'Carbohydrate', image: 'images/carb.png'),
    FoodClass(name: 'Vegetables', image: 'images/vegetable.png'),
    FoodClass(name: 'Fruit', image: 'images/fruit.png'),
    FoodClass(name: 'Drink', image: 'images/drink.png'),
  ];

  List<FoodClass> get foodClass => _foodClass;
  int get selectedDay => _selectedDay;
  bool get isFruit => _isFruit;
  bool get isVegetable => _isVegetable;
  bool get isCarb => _isCarb;
  bool get isProtein => _isProtein;
  bool get isDrink => _isDrink;
  String get selectedFoodClass => _selectedFoodClass;

  bool isFoodClassActive(String name) {
    switch (name) {
      case 'Protein':
        return isProtein;
        break;
      case 'Fruit':
        return isFruit;
        break;
      case 'Carbohydrate':
        return isCarb;
        break;
      case 'Drink':
        return isDrink;
        break;
      case 'Vegetables':
        return isVegetable;
        break;
    }
  }

  void updateSelectedFoodClass(String name) {
    this._selectedFoodClass = name;
    switch (name) {
      case 'Protein':
        this._isProtein = true;
        this._isCarb = false;
        this._isDrink = false;
        this._isFruit = false;
        this._isVegetable = false;
        notifyListeners();
        break;
      case 'Fruit':
        this._isProtein = false;
        this._isCarb = false;
        this._isDrink = false;
        this._isFruit = true;
        this._isVegetable = false;
        notifyListeners();
        break;
      case 'Carbohydrate':
        this._isProtein = false;
        this._isCarb = true;
        this._isDrink = false;
        this._isFruit = false;
        this._isVegetable = false;
        notifyListeners();
        break;
      case 'Drink':
        this._isProtein = false;
        this._isCarb = false;
        this._isDrink = true;
        this._isFruit = false;
        this._isVegetable = false;
        notifyListeners();
        break;
      case 'Vegetables':
        this._isProtein = false;
        this._isCarb = false;
        this._isDrink = false;
        this._isFruit = false;
        this._isVegetable = true;
        notifyListeners();
        break;
    }
  }

  int get daysInMonth => _daysInMonth;

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

  void updateSelectedTime(dynamic time) {
    this._selectedTime = time;
    print(time);
    print(time);
    notifyListeners();
  }

  void _getCurrentMonth() {
    switch (DateTime.now().month) {
      case 1:
        this._selectedMonth = 'January';
        this._month = 1;
        getDaysInMonth();
        notifyListeners();
        break;
      case 2:
        this._selectedMonth = 'February';
        this._month = 2;
        getDaysInMonth();
        notifyListeners();
        break;
      case 3:
        this._selectedMonth = 'March';
        this._month = 3;
        getDaysInMonth();
        notifyListeners();
        break;
      case 4:
        this._selectedMonth = 'April';
        this._month = 4;
        getDaysInMonth();
        notifyListeners();
        break;
      case 5:
        this._selectedMonth = 'May';
        this._month = 5;
        getDaysInMonth();
        notifyListeners();
        break;
      case 6:
        this._selectedMonth = 'June';
        this._month = 6;
        getDaysInMonth();
        notifyListeners();
        break;
      case 7:
        this._selectedMonth = 'July';
        this._month = 7;
        getDaysInMonth();
        notifyListeners();
        break;
      case 8:
        this._selectedMonth = 'August';
        this._month = 8;
        getDaysInMonth();
        notifyListeners();
        break;
      case 9:
        this._selectedMonth = 'September';
        this._month = 9;
        getDaysInMonth();
        notifyListeners();
        break;
      case 10:
        this._selectedMonth = 'October';
        this._month = 10;
        getDaysInMonth();
        notifyListeners();
        break;
      case 11:
        this._selectedMonth = 'November';
        this._month = 11;
        getDaysInMonth();
        notifyListeners();
        break;
      case 12:
        this._selectedMonth = 'December';
        this._month = 12;
        getDaysInMonth();
        notifyListeners();
        break;
    }
  }

//this might be useless but...
  void _initCurrentMonth() {
    switch (DateTime.now().month) {
      case 1:
        this._selectedMonth = 'January';
        this._month = 1;
        break;
      case 2:
        this._selectedMonth = 'February';
        this._month = 2;
        break;
      case 3:
        this._selectedMonth = 'March';
        this._month = 3;
        break;
      case 4:
        this._selectedMonth = 'April';
        this._month = 4;
        break;
      case 5:
        this._selectedMonth = 'May';
        this._month = 5;
        break;
      case 6:
        this._selectedMonth = 'June';
        this._month = 6;
        break;
      case 7:
        this._selectedMonth = 'July';
        this._month = 7;
        break;
      case 8:
        this._selectedMonth = 'August';
        this._month = 8;
        break;
      case 9:
        this._selectedMonth = 'September';
        this._month = 9;
        break;
      case 10:
        this._selectedMonth = 'October';
        this._month = 10;
        break;
      case 11:
        this._selectedMonth = 'November';
        this._month = 11;
        break;
      case 12:
        this._selectedMonth = 'December';
        this._month = 12;
        break;
    }
  }

  void get initCurrentMonth => _initCurrentMonth();
  void get getCurrentMonth => _getCurrentMonth();
  String get currentMonth => _selectedMonth;
  dynamic get selectedTime => _selectedTime;

  void updateSelectedMonth(String newMonth) {
    this._selectedMonth = newMonth;
    switch (newMonth) {
      case 'January':
        this._month = 1;
        getDaysInMonth();
        notifyListeners();
        break;
      case 'February':
        this._month = 2;
        getDaysInMonth();
        notifyListeners();
        break;
      case 'March':
        this._month = 3;
        getDaysInMonth();
        notifyListeners();
        break;
      case 'April':
        this._month = 4;
        getDaysInMonth();
        notifyListeners();
        break;
      case 'May':
        this._month = 5;
        getDaysInMonth();
        notifyListeners();
        break;
      case 'June':
        this._month = 6;
        getDaysInMonth();
        notifyListeners();
        break;
      case 'July':
        this._month = 7;
        getDaysInMonth();
        notifyListeners();
        break;
      case 'August':
        this._month = 8;
        getDaysInMonth();
        notifyListeners();
        break;
      case 'September':
        this._month = 9;
        getDaysInMonth();
        notifyListeners();
        break;
      case 'October':
        this._month = 10;
        getDaysInMonth();
        notifyListeners();
        break;
      case 'November':
        this._month = 11;
        getDaysInMonth();
        notifyListeners();
        break;
      case 'December':
        this._month = 12;
        getDaysInMonth();
        notifyListeners();
        break;
    }
  }

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
  bool isVisible = true;

  //functionality for making the FAB appear and disappear when user scrolls
  void updateVisibility(bool visible) {
    this.isVisible = visible;
    notifyListeners();
  }
}

//Custom class to hold data for food card
class FoodClass {
  final String image;
  final String name;

  FoodClass({this.image, this.name});
}
