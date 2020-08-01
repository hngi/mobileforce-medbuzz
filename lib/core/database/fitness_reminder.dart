import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import '../models/fitness_reminder_model/fitness_reminder.dart';

class FitnessReminderCRUD extends ChangeNotifier {
  static const String _boxName = "fitnessReminderBox";
  bool isEditing = false;
  final String add = "Add Fitness Reminder";
  final String edit = "Edit Fitness Reminder";
  DateTime _today = DateTime.now();
  int _selectedDay;
  int _selectedMonth;
  dynamic _selectedTime;
  int selectedIndex = 0;
  String selectedActivityType = 'images/jogging.png';
  String description;
  FitnessReminder reminder;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int index;
  // int _selectedActivity = 0;
//  int selectedFitnessType = 0;
  int minDaily = 60;
  TimeOfDay activityTime = TimeOfDay.now();
//  int id = Random().nextInt(100);
  String id;
  final List<String> frequency = [
    'Daily',
    'Once Every Week',
    'Twice Every Week',
    'Thrice Every Week',
    'Four Times Weekly'
  ];

  final List<String> days = ['Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
  String selectedDay = 'Mon';
  String selectedDay2 = 'Mon';
  String selectedDay3 = 'Mon';
  String selectedDay4 = 'Mon';
  String selectedFreq = "Daily";

  dynamic get selectedTime => _selectedTime;
  List<FitnessReminder> _fitnessReminder = [];
  List<FitnessReminder> get fitnessReminder => _fitnessReminder;
  List<FitnessReminder> _availableFitnessReminders = [];

  final List activityType = [
    'images/jogging.png',
    'images/swimming.png',
    'images/cycling.png',
    'images/volleyball.png',
    'images/tabletennis.png',
    'images/football.png',
    'images/badminton.png',
    'images/basketball.png',
    'images/golf.png',
    'images/benchpress.png',
    'images/pushups.png',
    'images/situps.png',
    'images/squats.png',
    'images/weightlifting.png'
  ];

  void incrementMinDaily() {
    minDaily >= 0 && minDaily < 60 ? minDaily++ : null;
    notifyListeners();
  }

  void decrementMinDaily() {
    minDaily > 0 ? minDaily-- : null;
    notifyListeners();
  }

  String updateSelectedActivityType(String activity) {
    this.selectedActivityType = activity == activityType[0]
        ? activityType[0]
        : activity == activityType[1]
            ? activityType[1]
            : activity == activityType[2]
                ? activityType[2]
                : activity == activityType[3]
                    ? activityType[3]
                    : activity == activityType[4]
                        ? activityType[4]
                        : activity == activityType[5]
                            ? activityType[5]
                            : activity == activityType[6]
                                ? activityType[6]
                                : activity == activityType[7]
                                    ? activityType[7]
                                    : activity == activityType[8]
                                        ? activityType[8]
                                        : activity == activityType[9]
                                            ? activityType[9]
                                            : activity == activityType[10]
                                                ? activityType[10]
                                                : activity == activityType[11]
                                                    ? activityType[11]
                                                    : activity ==
                                                            activityType[12]
                                                        ? activityType[12]
                                                        : activityType[13];

    return selectedActivityType;
  }

  List fitnessType = [
    'Jogging',
    'Swimming',
    'Cycling',
    'Volleyball',
    'Table Tennis',
    'Football',
    'Badminton',
    'Basketball',
    'Golf',
    'Bench Press',
    'Push Ups',
    'Sit Ups',
    'Squats',
    'Weightlifting'
  ];

  String updateFrequency(String freq) {
    this.selectedFreq = freq;

    notifyListeners();
    return selectedFreq;
  }

  String updateFreq(String freq) {
    this.selectedFreq = freq;
    notifyListeners();
    return selectedFreq;
  }

  int get reminderLength {
    return _fitnessReminder.length;
  }

  String updateDescription(String value) {
    description = value;
    notifyListeners();
    return description;
  }

  int updateMinDaily(int value) {
    minDaily = value;
    notifyListeners();
    return minDaily;
  }

//  int updateIndex(int value) {
//    index = value;
//    notifyListeners();
//    return index;
//  }

  void onSelectedFitnessImage(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void updateStartDate(DateTime selectedDate) {
    startDate = selectedDate;
    notifyListeners();
  }

  void updateEndDate(DateTime selectedDate) {
    endDate = selectedDate;
    notifyListeners();
  }

  TimeOfDay updateActivityTime(TimeOfDay selectedTime) {
    activityTime = selectedTime;
    notifyListeners();
    return activityTime;
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

  String updateID(String value) {
    id = value;
    notifyListeners();
    return id;
  }

  TimeOfDay convertTimeBack(List<int> list) {
    TimeOfDay value = TimeOfDay(hour: list[0], minute: list[1]);
    return value;
  }

  void getReminders() async {
    var box = await Hive.openBox<FitnessReminder>(_boxName);
    _fitnessReminder = box.values.toList();
    notifyListeners();
  }

  int updateSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
    return selectedIndex;
  }

  getOneReminder(index) {
    return _fitnessReminder[index];
  }

  void deleteFitnessReminders() async {
    try {
      var box = await Hive.openBox<FitnessReminder>(_boxName);
      box.deleteFromDisk();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addReminder(FitnessReminder reminder) async {
    var box = await Hive.openBox<FitnessReminder>(_boxName);
    await box.put(reminder.id, reminder);
    _fitnessReminder = box.values.toList();
    box.close();
    notifyListeners();
  }

  void editReminder(FitnessReminder reminder) async {
    var key = reminder.id;
    var box = Hive.box<FitnessReminder>(_boxName);
    await box.put(key, reminder);
    _fitnessReminder = box.values.toList();
    box.close();
    notifyListeners();
  }

  void deleteReminder(key) async {
    var box = await Hive.openBox<FitnessReminder>(_boxName);

    box.delete(key);
    _fitnessReminder = box.values.toList();
    box.close();

    notifyListeners();
  }

  List<FitnessReminder> get fitnessRemindersBasedOnDateTime {
    return _availableFitnessReminders
        .where((reminder) => selectedDateTime.day == reminder.startDate.day)
        .toList();
  }

//  List<FitnessReminder> get fitnessRemindersBasedOnDateTime {
//    // print(_availableFitnessReminders[0].startDate);
//    return _availableFitnessReminders
//        .where((element) =>
//            selectedDateTime.difference(element.startDate).inDays >= 0 &&
//            selectedDateTime.difference(element.endDate).inDays <= 0)
//        .toList();
//  }

  getDateTime() {
    final now = new DateTime.now();
    return DateTime(
        now.year, now.month, now.day, activityTime.hour, activityTime.minute);
  }

  DateTime get selectedDateTime => DateTime.now();
  //DateTime(_today.year, _selectedMonth, _selectedDay);

  void updateAvailableFitnessReminders(List<FitnessReminder> fitnessReminders) {
    _availableFitnessReminders = fitnessReminders;
    notifyListeners();
  }

//  DateTime getDateTime() {
//    String month = _selectedMonth.toString().length < 2
//        ? '0$_selectedMonth'
//        : '$_selectedMonth';
//    String weekday =
//        _selectedDay.toString().length < 2 ? '0$_selectedDay' : '$_selectedDay';
//    return DateTime.parse(
//        '${_today.year}-$month-$weekday ${_selectedTime.substring(0, 2)}:${selectedTime.substring(3, 5)}');
//  }
}
