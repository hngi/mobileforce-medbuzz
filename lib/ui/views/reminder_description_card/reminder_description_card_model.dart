import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:MedBuzz/core/models/fitness_reminder_model/fitness_reminder.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:flutter/material.dart';

class ReminderDescriptionCardModel extends ChangeNotifier {
  //gets name of notification depending on the type
  String getReminderName(dynamic model) {
    // return model is Appointment
    //     ? model.appointmentType
    //     : model is DietModel
    //         ? model.dietName
    //         : model is FitnessReminder
    //             ? model.fitnesstype
    //             : model is MedicationReminder
    //                 ? model.drugName
    //                 : 'Water Tracker';
    //instead check model reminderType
    switch (model.reminderType) {
      case 'water-model':
        return 'Water Tracker';
        break;
      case 'diet-model':
        return 'Diet Reminder';
        break;
      case 'fitness-model':
        return 'Fitness Reminder';
        break;
      case 'medication-model':
        return 'Medication Reminder';
        break;
      case 'appointment-model':
        return 'Appointment Reminder';
        break;
      default:
        return 'Generic Tracker';
    }
  }

  //gets image of notification depending on the type
  String getImage(dynamic model) {
    // return model is Appointment
    //     ? "images/calender.png"
    //     : model is DietModel
    //         ? "images/appointment.png"
    //         : model is FitnessReminder
    //             ? "images/dumbell.png"
    //             : model is MedicationReminder
    //                 ? "images/drugoutline.png"
    //                 : 'images/dropoutline.png';
    switch (model.reminderType) {
      case 'water-model':
        return 'images/dropoutline.png';
        break;
      case 'diet-model':
        return "images/appointment.png";
        break;
      case 'fitness-model':
        return "images/dumbell.png";
        break;
      case 'medication-model':
        return "images/drugoutline.png";
        break;
      case 'appointment-model':
        return "images/calender.png";
        break;
      default:
        return 'images/dropoutline.png';
    }
  }

  void getTime() {}

  void getDate() {}

//checks the total points depending on the notification type
  int getTotalPoints(model, db) {
    switch (model.reminderType) {
      case 'water-model':
        return db.totalWaterPointsForTheWeek;
        break;
      case 'diet-model':
        return db.totalDietPointsForTheWeek;
        break;
      case 'fitness-model':
        return db.totalFitnessPointsForTheWeek;
        break;
      case 'medication-model':
        return db.totalMedicationPointsForTheWeek;
        break;
      case 'appointment-model':
        return db.totalAppointmentPointsForTheWeek;
        break;
      default:
        return 0;
    }
  }

  int getCompletedPoints(model, db) {
    switch (model.reminderType) {
      case 'water-model':
        return db.totalWaterCompletedPointsForTheWeek;
        break;
      case 'diet-model':
        return db.totalDietCompletedPointsForTheWeek;
        break;
      case 'fitness-model':
        return db.totalFitnessCompletedPointsForTheWeek;
        break;
      case 'medication-model':
        return db.totalMedicationCompletedPointsForTheWeek;
        break;
      case 'appointment-model':
        return db.totalAppointmentCompletedPointsForTheWeek;
        break;
      default:
        return 0;
    }
  }
}
