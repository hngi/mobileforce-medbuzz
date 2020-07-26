import 'package:MedBuzz/core/models/badge_model.dart';
import 'package:MedBuzz/core/models/fitness_reminder_model/fitness_reminder.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class NewFitnessCardModel extends ChangeNotifier {
  int _totalPoints = 0;
  int get totalPoints => _totalPoints;
  List _benchmarks = badges;

  int _nextBenchMark = 50;
  int get nextBenchMark => _nextBenchMark;
  final String _boxName = 'fitnessPoints';
  final String _key = 'points';
  String getReminderName(FitnessReminder reminderModel) {
    return reminderModel.fitnesstype;
  }

  void getTime() {}

  String getDate(FitnessReminder reminder) {
    return DateFormat.yMMMMd().format(reminder.startDate);
  }

  String getPoints() {
    return '$totalPoints/$nextBenchMark';
  }

  void onDoneTap() async {
    try {
      var box = await Hive.openBox(_boxName);
      int points = box.get(_key);
      if (points == null) {
        box.put(_key, 5);
        _totalPoints = 5;
        _nextBenchMark = _benchmarks[0].points;
        notifyListeners();
        box.close();
        return;
      } else {
        box.put(_key, points + 5);
        _totalPoints = points + 5;
        notifyListeners();
        if (_totalPoints < 50) {
          _nextBenchMark = _benchmarks[0].points;
          notifyListeners();
        }
        if (_totalPoints > 50 && _totalPoints < 100) {
          _nextBenchMark = _benchmarks[1].points;
          notifyListeners();
        }
        if (_totalPoints > 100 && _totalPoints < 150) {
          _nextBenchMark = _benchmarks[2].points;
          notifyListeners();
        }
        if (_totalPoints > 150 && _totalPoints < 200) {
          _nextBenchMark = _benchmarks[3].points;
          notifyListeners();
        }
        if (_totalPoints > 200 && _totalPoints < 250) {
          _nextBenchMark = _benchmarks[4].points;
          notifyListeners();
        }
        if (_totalPoints > 250 && _totalPoints < 300) {
          _nextBenchMark = _benchmarks[5].points;
          notifyListeners();
        }
        if (_totalPoints > 300 && _totalPoints < 350) {
          _nextBenchMark = _benchmarks[6].points;
          notifyListeners();
        }
        if (_totalPoints > 350 && _totalPoints < 400) {
          _nextBenchMark = _benchmarks[7].points;
          notifyListeners();
        }
        if (_totalPoints > 400 && _totalPoints <= 450) {
          _nextBenchMark = _benchmarks[8].points;
          notifyListeners();
        }
      }
      print('$_totalPoints/$_nextBenchMark');
      box.close();
    } catch (e) {
      print(e);
    }
  }
}
