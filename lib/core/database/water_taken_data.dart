import 'package:MedBuzz/core/models/water_reminder_model/water_drank.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class WaterTakenData extends ChangeNotifier {
  static const String _boxName = "waterTakenBox";

  List<WaterDrank> _waterTaken = [];

  List<WaterDrank> get waterTaken => _waterTaken;

  void getWaterTaken() async {
    try {
      var box = await Hive.openBox<WaterDrank>(_boxName);

      _waterTaken = box.values.toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

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
