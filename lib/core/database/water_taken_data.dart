import 'package:MedBuzz/core/models/water_reminder_model/water_drank.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/water_reminder_model/water_reminder.dart';

class WaterTakenData extends ChangeNotifier {
  static const String _boxName = "waterTakenBox";

  List<WaterDrank> _waterTaken = [];
  // List<WaterReminder> _sortedReminders = [];

  List<WaterDrank> get waterTaken => _waterTaken;
  // List<WaterReminder> get sortedReminders => _sortedReminders;

  // WaterReminder _activeWaterReminder;
  // bool done = false;
  // bool skip = false;
  void getWaterTaken() async {
    try {
      var box = await Hive.openBox<WaterDrank>(_boxName);

      _waterTaken = box.values.toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // WaterReminder getWaterReminder(index) {
  //   return _waterTaken[index];
  // }

  // int get currentLevel => _waterTaken
  //     .map((e) => e.ml)
  //     .reduce((value, element) => value + element);

  // int get totalLevel => _waterTaken
  //     .map((e) => e.ml)
  //     .reduce((value, element) => value + element);

  Future<void> addWaterTaken(int ml, DateTime dateTime) async {
    var box = await Hive.openBox<WaterDrank>(_boxName);
    WaterDrank waterTaken = WaterDrank(ml: ml, dateTime: dateTime);
    await box.put(waterTaken.dateTime.toString(), waterTaken);

    //reinitialise water reminders after write operation
    _waterTaken = box.values.toList();

    // box.close();

    notifyListeners();
  }

  Future<void> deleteWaterTaken(key) async {
    try {
      await Hive.openBox<WaterDrank>(_boxName)
          .then((value) => value.delete(key));

      //delete the water reminder
      // print(box.get(key));
      // box.close();
      // getWaterTaken();
      // then reinitialise the water reminders
      // _waterTaken = box.values.toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAllWaterTaken() async {
    try {
      await Hive.openBox<WaterDrank>(_boxName).then((value) async {
        for (var item in _waterTaken) {
          await deleteWaterTaken(item.dateTime.toString());
        }
      });

      //delete the water reminder
      // print(box.get(key));
      // box.close();
      // getWaterTaken();
      // then reinitialise the water reminders
      // _waterTaken = box.values.toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void editWaterReminder({WaterDrank waterDrank, String waterDrankKey}) async {
    var box = await Hive.openBox<WaterDrank>(_boxName);

    await box.put(waterDrank.dateTime.toString(), waterDrank);

    _waterTaken = box.values.toList();
    box.close();

    // _activeWaterReminder = box.get(waterReminderKey);

    notifyListeners();
  }

  // void setActiveWaterReminder(key) async {
  //   var box = await Hive.openBox<WaterReminder>(_boxName);

  //   _activeWaterReminder = box.get(key);

  //   notifyListeners();
  // }

  // List<WaterReminder> getActiveReminders() {
  //   // var today = DateTime.now().add(Duration(days: 5));

  //   return _waterTaken;
  // }

  int get waterTakenCount {
    return _waterTaken.length;
  }

  int get totalLevel {
    // if (_waterTaken.isEmpty) {
    //   return 0;
    // }
    return 3500;
    // return getActiveReminders()[0]?.ml ?? 0;
  }

  int get currentLevel {
    var today = DateTime.now();
    var taken = _waterTaken
        .where((element) => today.difference(element.dateTime).inDays == 0);
    if (_waterTaken.isEmpty) {
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
//  return currentLevel <= 100
//         ? 0
//         : currentLevel <= 500
//             ? 0.2
//             : currentLevel < 1500
//                 ? 0.3
//                 : currentLevel == 1500
//                     ? 0.5
//                     : currentLevel <= 2000
//                         ? 0.6
//                         : currentLevel < 3000 ? 0.8 : 1;
