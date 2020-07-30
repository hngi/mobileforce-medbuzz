import 'dart:core';

import 'package:MedBuzz/core/models/medication_history_model/medication_history.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MedicationHistoryData extends ChangeNotifier {
  static const String _boxName = "medicationHistoryBox";

  List<MedicationHistory> _medicationHistory = [];

  List<MedicationHistory> get medicationHistory => _medicationHistory;

  //-----------------test values -----------------------
  static MedicationHistory one = MedicationHistory(
    drugName: "Instagram",
    frequency: "Once",
    startAt: DateTime.now(),
    endAt: DateTime.now(),
  );
  List<MedicationHistory> _test = [one, one, one];
  List<MedicationHistory> get test => _test;

  //-----------------end-----------------

  Future<void> addMedicationReminderHistory(MedicationHistory history) async {
    var box = await Hive.openBox<MedicationHistory>(_boxName);

    await box.put(history.id.toString(), history);

    _medicationHistory = box.values.toList();

    box.close();

    notifyListeners();
  }

  void updateAvailableMedicationHistory(medicationHistory) {
    _medicationHistory = medicationHistory;
    notifyListeners();
  }

  void deleteMedicationHistories() async {
    try {
      var box = await Hive.openBox<MedicationHistory>(_boxName);
      box.deleteFromDisk();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void deleteScheduleHistory(key) async {
    var box = await Hive.openBox<MedicationHistory>(_boxName);

    _medicationHistory = box.values.toList();
    box.delete(key);
    box.close();

    notifyListeners();
  }

  void clearHistory() async {
    var box = await Hive.openBox<MedicationHistory>(_boxName);
    await box.clear();
    _medicationHistory = box.values.toList();

    notifyListeners();
  }

  Future<bool> isBoxEmpty() async {
    var box = await Hive.openBox<MedicationHistory>(_boxName);
    return box.isEmpty;
  }

  void getMedicationHistory() async {
    var box = await Hive.openBox<MedicationHistory>(_boxName);

    if (box.isNotEmpty) {
      _medicationHistory = box.values.toList();
    } else {}

    notifyListeners();
  }
}
