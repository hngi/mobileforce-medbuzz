import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:MedBuzz/core/models/fitness_reminder_model/fitness_reminder.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String getTime(dynamic model) {
    //  return model is Appointment
    //     ? _formatDate(model.date)
    //     : model is DietModel
    //         ? _formatDate(model.startDate)
    //         : model is FitnessReminder
    //             ? _formatDate(model.startDate)
    //             : _formatDate(model.startAt);
  }

  String getDate(dynamic model) {
    return model is Appointment
        ? _formatDate(model.date)
        : model is DietModel
            ? _formatDate(model.startDate)
            : model is FitnessReminder
                ? _formatDate(model.startDate)
                : _formatDate(model.startAt);
  }

  DateTime getTimeField(model) {
    return model is Appointment
        ? model.date
        : model is DietModel
            ? model.startDate
            : model is FitnessReminder
                ? model.startDate
                : model is MedicationReminder ? model.startAt : model.dateTime;
  }
}

String _formatDate(DateTime date) {
  return DateFormat.yMMMMd().format(date);
}
