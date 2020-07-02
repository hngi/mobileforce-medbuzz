import 'package:flutter/cupertino.dart';

// Functions for the properties would be created and used in screen file
class ScheduleAppointmentModel extends ChangeNotifier {
  DateTime today = DateTime.now();
  int selectedDay;
  int selectedMonth;
  dynamic selectedTime;
  String typeOfAppointment;
  String note;

  ScheduleAppointmentModel(
      {this.today,
      this.selectedDay,
      this.selectedMonth,
      this.selectedTime,
      this.typeOfAppointment,
      this.note});

  void updateSelectedTime(dynamic time) {
    selectedTime = time;
  }

  int get userSelectedDay => selectedDay;
  setSelectedDay(int userSelectedDay) => selectedDay = userSelectedDay;

  int get userSelectedMonth => selectedMonth;
  setSelectedMonth(int userSelectedMonth) => selectedMonth = userSelectedMonth;

  dynamic get userSelectedTime => selectedTime;
  setSelectedTime(dynamic userSelectedTime) => selectedTime = userSelectedTime;
}
