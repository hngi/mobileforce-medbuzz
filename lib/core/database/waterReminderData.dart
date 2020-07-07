import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/water_reminder_model/water_reminder.dart';

class WaterReminderData extends ChangeNotifier {
  static const String _boxName = "waterReminderBox";

  List<WaterReminder> _waterReminders = [];
  List<WaterReminder> _sortedReminders = [];

  List<WaterReminder> get waterReminders => _waterReminders;
  List<WaterReminder> get sortedReminders => _sortedReminders;

  WaterReminder _activeWaterReminder;

  void getWaterReminders() async {
    var box = await Hive.openBox<WaterReminder>(_boxName);

    _waterReminders = box.values.toList();

    notifyListeners();
  }

  WaterReminder getWaterReminder(index) {
    return _waterReminders[index];
  }

  void addWaterReminder(WaterReminder waterReminder) async {
    var box = await Hive.openBox<WaterReminder>(_boxName);

    await box.put(waterReminder.id, waterReminder);

    //reinitialise water reminders after write operation
    _waterReminders = box.values.toList();

    box.close();

    notifyListeners();
  }

  void deleteWaterReminder(key) async {
    var box = await Hive.openBox<WaterReminder>(_boxName);

    //delete the water reminder
    await box.delete(key);

    // then reinitialise the water reminders
    _waterReminders = box.values.toList();

    box.close();

    notifyListeners();
  }

  void editWaterReminder(
      {WaterReminder waterReminder, String waterReminderKey}) async {
    var box = await Hive.openBox<WaterReminder>(_boxName);

    await box.put(waterReminderKey, waterReminder);

    _waterReminders = box.values.toList();
    box.close();

    // _activeWaterReminder = box.get(waterReminderKey);

    notifyListeners();
  }

  void setActiveWaterReminder(key) async {
    var box = await Hive.openBox<WaterReminder>(_boxName);

    _activeWaterReminder = box.get(key);

    notifyListeners();
  }

  WaterReminder getActiveAppointment() {
    return _activeWaterReminder;
  }

  int get waterRemindersCount {
    return _waterReminders.length;
  }

  int get totalLevel {
    if (_waterReminders.isEmpty) {
      return 0;
    }
    return _waterReminders
        .map((e) => e.ml)
        .reduce((value, element) => value + element);
  }

  int get currentLevel {
    var taken = _waterReminders.where((element) => element.isTaken == true);
    if (taken.isEmpty) {
      return 0;
    }
    return taken.map((e) => e.ml).reduce((value, element) => value + element);

    // return val;
  }

  double get progress {
    var value = currentLevel / totalLevel;
    return value.isNaN ? 0.0 : value;
  }
}
