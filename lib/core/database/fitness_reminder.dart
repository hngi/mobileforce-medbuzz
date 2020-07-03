import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/fitness_reminder_model/fitness_reminder.dart';

class FitnessReminderCRUD extends ChangeNotifier {
  static const String _boxName = "fitnessReminderBox";
  List<FitnessReminder> fitnessReminder = [];

  int get reminderLength {
    return this.fitnessReminder.length;
  }

  void getReminders() async {
    var box = await Hive.openBox<FitnessReminder>(_boxName);
    fitnessReminder = box.values.toList();
    notifyListeners();
  }

  getOneReminder(index) {
    return fitnessReminder[index];
  }

  void addReminder(int index, FitnessReminder reminder) async {
    var box = Hive.box<FitnessReminder>(_boxName);
    await box.put(index, reminder);
    this.fitnessReminder = box.values.toList();
    box.close();
    notifyListeners();
  }

  void editReminder(FitnessReminder reminder) async {
    int key = reminder.index;
    var box = Hive.box<FitnessReminder>(_boxName);
    await box.putAt(key, reminder);
    this.fitnessReminder = box.values.toList();
    box.close();
    notifyListeners();
  }

  void deleteReminder(FitnessReminder reminder) async {
    int key = reminder.index;
    var box = Hive.box<FitnessReminder>(_boxName);
    this.fitnessReminder = box.values.toList();
    await box.delete(key);
    box.close();
  }
}
