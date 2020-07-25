import 'package:MedBuzz/core/models/fitness_reminder_model/fitness_reminder.dart';
import 'package:flutter/material.dart';

class NewFitnessCardModel extends ChangeNotifier {
  String getReminderName(FitnessReminder reminderModel) {
    return reminderModel.fitnesstype;
  }

  void getTime() {}

  void getDate() {}
}
