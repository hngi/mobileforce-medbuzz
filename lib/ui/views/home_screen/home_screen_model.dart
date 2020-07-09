import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:flutter/cupertino.dart';
import 'package:MedBuzz/ui/views/all_reminders/all_reminders_view_model.dart';

class HomeScreenModel extends ChangeNotifier {
  int _initialIndex = 0;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  int get initialIndex => _initialIndex;

  List<MedicationReminder> _availableMedicationReminders = [];
  List<Appointment> _availableAppointmentReminders = [];

  DateTime _today = DateTime.now();
  int _selectedMonth;
  int _selectedDay;
  dynamic _selectedTime;

  HomeScreenModel() {
    this._selectedMonth = _today.month;
    this._selectedDay = _today.day;
    this._selectedTime = null;
  }

  void updateCurrentIndex(int index) {
    this._currentIndex = index;
    notifyListeners();
  }

  DateTime get selectedDateTime =>
      DateTime(_today.year, _selectedMonth, _selectedDay);

  void updateAvailableMedicationReminders(
      List<MedicationReminder> medicationReminders) {
    _availableMedicationReminders = medicationReminders;
    notifyListeners();
  }

  void updateAvailableAppointmentReminders(
      List<Appointment> appointmentReminders) {
    _availableAppointmentReminders = appointmentReminders;
    notifyListeners();
  }

  List<MedicationReminder> get medicationReminderBasedOnDateTime {
    return _availableMedicationReminders
        .where((medication) => selectedDateTime.day == medication.startAt.day)
        .toList();
  }

  List<Appointment> get appointmentReminderBasedOnDateTime {
    return _availableAppointmentReminders
        .where((appointment) => selectedDateTime.day == appointment.date.day)
        .toList();
  }

  String greeting() {
                  var hour = DateTime.now().hour;
                  if (hour < 12) {
                    return 'Good Morning,';
                  }
                  if (hour < 17) {
                    return 'Good Afternoon,';
                  }
                  return 'Good Evening,';
                }
}
