import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:MedBuzz/core/models/fitness_reminder_model/fitness_reminder.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:flutter/material.dart';

class ReminderDescriptionCardModel extends ChangeNotifier {
  String getReminderName(dynamic model) {
    return model is Appointment
        ? model.appointmentType
        : model is DietModel
            ? model.dietName
            : model is FitnessReminder
                ? model.fitnesstype
                : model is MedicationReminder
                    ? model.drugName
                    : 'Water Tracker';
  }

  String getImage(dynamic model) {
    return model is Appointment
        ? "images/calender.png"
        : model is DietModel
            ? "images/appointment.png"
            : model is FitnessReminder
                ? "images/dumbell.png"
                : model is MedicationReminder
                    ? "images/drugoutline.png"
                    : 'images/dropoutline.png';
  }

  void getTime() {}

  void getDate() {}
}
