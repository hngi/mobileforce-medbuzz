import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

//El oh El A lot of magic happened here that I did not document
class DietReminderModel extends ChangeNotifier {
  //Some static fields to load current month and prevent an error
  static DateTime __today = DateTime.now();
  static int __month = __today.month;
  int minDaily = 30;

  List<String> _selectedFoodClasses = [];
  TimeOfDay activityTime = TimeOfDay.now();
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
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  int get currentDay => _currentDay;
  List<String> get selectedFoodClasses => _selectedFoodClasses;

  List<DietModel> _allDiets = [];
  List<DietModel> get allDiets => _allDiets;

  int get month => _month;

  DateTime getSelectedDate() => DateTime.parse(
      '${__today.year}-${_month.toString().padLeft(2, '0')}-${_selectedDay.toString().padLeft(2, '0')} $_selectedTime');

  TimeOfDay updateActivityTime(TimeOfDay selectedTime) {
    activityTime = selectedTime;
    notifyListeners();
    return activityTime;
  }

  void updateStartDate(DateTime selectedDate) {
    startDate = selectedDate;
    notifyListeners();
  }

  void updateEndDate(DateTime selectedDate) {
    endDate = selectedDate;
    notifyListeners();
  }

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
    return DateFormat.MMMM().format(DateTime.parse(
        '${__today.year}-${month.toString().padLeft(2, '0')}-01'));
  }

  //this function is used on the AllDietReminders screen to convert the weekday
  //retrieved from the date of the reminder from int to string

  String weekayFromInt(int weekday) {
    return DateFormat.E().format(DateTime.parse(
        '${__today.year}-${month.toString().padLeft(2, '0')}-${weekday.toString().padLeft(2, '0')}'));
  }

  DateTime getStartDate() {
    String month = startDate.month.toString().padLeft(2, '0');
    String weekday = startDate.day.toString().padLeft(2, '0');
    return DateTime.parse('${_today.year}-$month-$weekday $_selectedTime');
  }

  DateTime getEndDate() {
    String month = endDate.month.toString().padLeft(2, '0');
    String weekday = endDate.day.toString().padLeft(2, '0');
    return DateTime.parse('${_today.year}-$month-$weekday $_selectedTime');
  }

  int updateDay(String selectedDay) {
    int day;
    day = selectedDay == 'Mon'
        ? 1
        : selectedDay == 'Tues'
            ? 2
            : selectedDay == 'Wed'
                ? 3
                : selectedDay == 'Thur'
                    ? 4
                    : selectedDay == 'Fri' ? 5 : selectedDay == 'Sat' ? 6 : 7;
//    selectedTime == 'Monday' ? day = 1 : 2;
    notifyListeners();
    print(day);
    return day;
  }

  Day updateNameDay(String selectedDay) {
    Day day;
    day = selectedDay == 'Mon'
        ? Day.Monday
        : selectedDay == 'Tues'
            ? Day.Tuesday
            : selectedDay == 'Wed'
                ? Day.Wednesday
                : selectedDay == 'Thur'
                    ? Day.Thursday
                    : selectedDay == 'Fri'
                        ? Day.Friday
                        : selectedDay == 'Sat' ? Day.Saturday : Day.Sunday;
//    selectedTime == 'Monday' ? day = 1 : 2;
    notifyListeners();
    print(day);
    return day;
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
      _selectedFoodClasses.remove(foodClass);
      notifyListeners();
      return;
    }
    if (!_selectedFoodClasses.contains(foodClass)) {
      _selectedFoodClasses.add(foodClass);
      notifyListeners();
      return;
    }
  }

  void getDaysInMonth() {
    _daysInMonth = DateUtil().daysInMonth(_month, _today.year);
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

  String selectedFreq = "Daily";

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
//initial logic for this
  // Future<double> getNumberOfDietsWithFoodClass(String className) async {
  //   var box = await Hive.openBox('dietReminderBox');
  //   var diets = box.values.toList();
  //   box.close();
  //   return diets
  //       .where((element) =>
  //           element.isDone == true && element.foodClasses.contains(className))
  //       .toList()
  //       .length
  //       .toDouble();
  // }

  void updateFreq(val) {
    selectedFreq = val;
    notifyListeners();
  }

  void updateSelectedFoodClass(String name) {
    this._selectedFoodClass = name;
    switch (name) {
      case 'Protein':
        _isProtein = true;
        _isCarb = false;
        _isDrink = false;
        _isFruit = false;
        _isVegetable = false;
        notifyListeners();
        break;
      case 'Fruit':
        _isProtein = false;
        _isCarb = false;
        _isDrink = false;
        _isFruit = true;
        _isVegetable = false;
        notifyListeners();
        break;
      case 'Carbohydrate':
        _isProtein = false;
        _isCarb = true;
        _isDrink = false;
        _isFruit = false;
        _isVegetable = false;
        notifyListeners();
        break;
      case 'Drink':
        _isProtein = false;
        _isCarb = false;
        _isDrink = true;
        _isFruit = false;
        _isVegetable = false;
        notifyListeners();
        break;
      case 'Vegetables':
        _isProtein = false;
        _isCarb = false;
        _isDrink = false;
        _isFruit = false;
        _isVegetable = true;
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
    _selectedTime = time;
    print(time);
    // print(time);
    // notifyListeners();
  }

  void _getCurrentMonth() {
    _selectedMonth = monthFromInt(DateTime.now().month);
    _month = DateTime.now().month;
    getDaysInMonth();
    notifyListeners();
  }

//this might be useless but...
  void _initCurrentMonth() {
    _selectedMonth = monthFromInt(DateTime.now().month);
    _month = DateTime.now().month;
  }

  void get initCurrentMonth => _initCurrentMonth();
  void get getCurrentMonth => _getCurrentMonth();
  String get currentMonth => _selectedMonth;
  dynamic get selectedTime => _selectedTime;

  void updateSelectedMonth(String newMonth, indx) {
    _selectedMonth = newMonth;
    _month = indx + 1;
    getDaysInMonth();
    notifyListeners();
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

  final List<String> frequency = [
    'Daily',
    'Once Every Week',
    'Twice Every Week',
    'Thrice Every Week',
    'Four Time Weekly'
  ];

  final List<String> daysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thur',
    'Fri',
    'Sat',
    'Sun',
  ];

  final List<int> selectedDaysOfWeek = [];

  void updateSelectedDaysOfWeek(int weekday) {
    //DateTime weekday starts at 1 as Monday and 7 as Sunday
    if (selectedDaysOfWeek.contains(weekday)) {
      //remove the day from selected if it is already there
      selectedDaysOfWeek.removeWhere((item) => item == weekday);
    } else {
      //add it to the selected if it is not
      selectedDaysOfWeek.add(weekday);
    }
    notifyListeners();
  }

  Color selectDayColor(context, weekday) {
    return selectedDaysOfWeek.contains(weekday)
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColorLight;
  }

  Color selectDayTextColor(context, weekday) {
    return selectedDaysOfWeek.contains(weekday)
        ? Theme.of(context).primaryColorLight
        : Theme.of(context).primaryColorDark;
  }

  getDateTime() {
    final now = new DateTime.now();
    return DateTime(
        now.year, now.month, now.day, activityTime.hour, activityTime.minute);
  }

//   int updateDay(String selectedDay) {
//     int day;
//     day = selectedDay == 'Mon'
//         ? 1
//         : selectedDay == 'Tues'
//             ? 2
//             : selectedDay == 'Wed'
//                 ? 3
//                 : selectedDay == 'Thur'
//                     ? 4
//                     : selectedDay == 'Fri' ? 5 : selectedDay == 'Sat' ? 6 : 7;
// //    selectedTime == 'Monday' ? day = 1 : 2;
//     notifyListeners();
//     print(day);
//     return day;
//   }

  void incrementMinDaily() {
    minDaily >= 0 && minDaily < 60 ? minDaily++ : null;
    notifyListeners();
  }

  void decrementMinDaily() {
    minDaily > 0 ? minDaily-- : null;
    notifyListeners();
  }

  final List<String> days = ['Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
  String selectedDayName = 'Mon';
  String selectedDayName2 = 'Mon';
  String selectedDayName3 = 'Mon';
  String selectedDayName4 = 'Mon';

  List<DietModel> get upcomingDiets {
    return _allDiets
        .where((element) => _today.difference(element.startDate).inDays > 0)
        .toList();
  }

  List<DietModel> get ongoingDiets {
    return _allDiets
        .where((element) =>
            _today.difference(element.startDate).inDays >= 0 &&
            element.endDate.difference(_today).inDays >= 0)
        .toList();
  }

  List<DietModel> get pastDiets {
    return _allDiets
        .where((element) => _today.difference(element.endDate).inDays > 0)
        .toList();
  }

  void updateAllDietsBasedOnToday(List<DietModel> diets) {
    _allDiets = diets;
    notifyListeners();
  }

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
