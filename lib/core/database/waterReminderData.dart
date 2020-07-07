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
      {WaterReminder waterReminder, int waterReminderKey}) async {
    var box = await Hive.openBox<WaterReminder>(_boxName);

    await box.putAt(waterReminderKey, waterReminder);

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
}
