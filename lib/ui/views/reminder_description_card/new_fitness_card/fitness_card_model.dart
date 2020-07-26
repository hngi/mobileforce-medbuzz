import 'package:MedBuzz/core/models/fitness_reminder_model/fitness_reminder.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NewFitnessCardModel extends ChangeNotifier {
  int _totalPoints;
  int get totalPoints => _totalPoints;

  int _nextBenchMark;
  int get nextBenchMark => _nextBenchMark;
  final String _boxName = 'fitnessPoints';
  final String _key = 'points';
  String getReminderName(FitnessReminder reminderModel) {
    return reminderModel.fitnesstype;
  }

  void getTime() {}

  void getDate() {}

  void onDoneTap() async {
    try {
      var box = await Hive.openBox(_boxName);
      int points = box.get(_key);
      if (points == null) {
        box.put(_key, 5);
        _totalPoints = 5;
        notifyListeners();
      } else {
        box.put(_key, points + 5);
        _totalPoints = points + 5;
        notifyListeners();
      }
      box.close();
    } catch (e) {
      print(e);
    }
  }
}
