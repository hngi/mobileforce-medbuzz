import 'package:MedBuzz/ui/views/signup_page/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/fitness_reminder_model/fitness_reminder.dart';
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

  String selectedFreq = "Daily";

  dynamic get selectedTime => _selectedTime;
  List<FitnessReminder> _fitnessReminder = [];
  List<FitnessReminder> get fitnessReminder => _fitnessReminder;

  final List activityType = [
    'images/jogging.png',
    'images/swimming.png',
    'images/cycling.png',
    'images/volleyball.png',
    'images/tabletennis.png',
    'images/football.png',
    'images/badminton.png',
    'images/basketball.png'
  ];

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
                                : activityType[7];

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
    'Basketball'
  ];

  String updateFreq(String freq) {
    this.selectedFreq = freq;
    notifyListeners();
    return selectedFreq;
  }

  int get reminderLength {
    return _fitnessReminder.length;
  }

  String updateDescription(String value) {
    this.description = value;
    notifyListeners();
    return description;
  }

  void onSelectedFitnessImage(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void updateStartDate(DateTime selectedDate) {
    this.startDate = selectedDate;
    notifyListeners();
  }

  void updateEndDate(DateTime selectedDate) {
    this.endDate = selectedDate;
    notifyListeners();
  }

  TimeOfDay updateActivityTime(TimeOfDay selectedTime) {
    this.activityTime = selectedTime;
    notifyListeners();
    return activityTime;
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
    this.selectedIndex = index;
    notifyListeners();
    return this.selectedIndex;
  }

  getOneReminder(index) {
    return _fitnessReminder[index];
  }

  Future<void> addReminder(FitnessReminder reminder) async {
    var box = await Hive.openBox<FitnessReminder>(_boxName);
    await box.put(reminder.id, reminder);
    _fitnessReminder = box.values.toList();
    box.close();
    notifyListeners();
  }

  void editReminder(FitnessReminder reminder) async {
    int key = reminder.index;
    var box = Hive.box<FitnessReminder>(_boxName);
    await box.putAt(key, reminder);
    _fitnessReminder = box.values.toList();
    box.close();
    notifyListeners();
  }

  void deleteReminder(key) async {
    var box = await Hive.openBox<FitnessReminder>(_boxName);

    _fitnessReminder = box.values.toList();
    box.delete(key);
    box.close();

    notifyListeners();
  }

  DateTime getDateTime() {
    String month = _selectedMonth.toString().length < 2
        ? '0$_selectedMonth'
        : '$_selectedMonth';
    String weekday =
        _selectedDay.toString().length < 2 ? '0$_selectedDay' : '$_selectedDay';
    return DateTime.parse(
        '${_today.year}-$month-$weekday ${_selectedTime.substring(0, 2)}:${selectedTime.substring(3, 5)}');
  }
}
