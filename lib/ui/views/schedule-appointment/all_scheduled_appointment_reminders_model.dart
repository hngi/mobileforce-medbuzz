import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:flutter/cupertino.dart';

class MenuItem {
  String menuValue;

  MenuItem(this.menuValue);
}

final List<MenuItem> menuitems = [
  MenuItem("Edit"),
  MenuItem("Delete"),
];

class AppointmentViewModel extends ChangeNotifier {
  DateTime _today = DateTime.now();
  // int _selectedMl;
  int _selectedDay;
  int _selectedMonth;
  dynamic _selectedTime;
  List<Appointment> _allAvailableAppoitments = [];
  // List<Appointment> _allAvailableAppointments = [];

  AppointmentViewModel() {
    this._selectedMonth = _today.month;
    this._selectedDay = _today.day;
    this._selectedTime = null;
  }

  int get selectedDay => _selectedDay;
  setSelectedDay(int selectedDay) => _selectedDay = selectedDay;

  int get selectedMonth => _selectedMonth;
  setSelectedMonth(int selectedMonth) => _selectedMonth = selectedMonth;

  dynamic get selectedTime => _selectedTime;
  setSelectedTime(dynamic selectedTime) => _selectedTime = selectedTime;

  DateTime get selectedDateTime =>
      DateTime(_today.year, _selectedMonth, _selectedDay);

  void updateAvailableAppointmentReminders(List<Appointment> appointments) {
    _allAvailableAppoitments = appointments;
    notifyListeners();
  }

  List<Appointment> get allAppointments {
    return _allAvailableAppoitments;
  }

  List<Appointment> get appointmentsBasedOnDateTime {
    return _allAvailableAppoitments
        .where((appointment) => selectedDateTime.day == appointment.date.day)
        .toList();
  }

  List<Appointment> get pastApointments {
    return _allAvailableAppoitments
        .where((appointment) => selectedDateTime.day > appointment.date.day)
        .toList();
  }
}
//class TodaysDate {
//  String month = 'July';
//  int dateno = 12;
//  String day = 'Thurs';
//
//  TodaysDate(this.month, this.dateno, this.day);
//}

// enum _reminderState {Completed, Skipped, Upcoming}

//// Future action to return reminder state
//for each ListItem {
//  if (DateAndDay > Date.time(now)) {
//    print('Reminder is Completed.');
//    else{
//      print('Reminder was Skipped');
//}
//  } else {
//    print('Reminder is Upcoming');
//}
//
//}
