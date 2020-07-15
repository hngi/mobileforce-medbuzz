import 'dart:core';

import 'package:MedBuzz/core/models/medication_history_model/medication_history.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MedicationHistoryData extends ChangeNotifier {
  static const String _boxName = "medicationHistoryBox";

  List<MedicationHistory> _medicationHistory = [];

  List<MedicationHistory> get medicationHistory => _medicationHistory;

  void getMedicationHistory() async {
    var box = await Hive.openBox<MedicationHistory>(_boxName);

    _medicationHistory = box.values.toList();

    notifyListeners();
  }


}