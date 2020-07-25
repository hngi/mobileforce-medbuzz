import 'package:MedBuzz/core/database/medication_data.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:flutter/material.dart';

class NewMedicationCardModel extends ChangeNotifier {
  String getReminderName(MedicationReminder reminderModel) {
    return reminderModel.drugName;
  }

  String getImage(MedicationData dbModel) {
    return dbModel.selectedDrugType;
  }

  void getTime() {}

  void getDate() {}
}
