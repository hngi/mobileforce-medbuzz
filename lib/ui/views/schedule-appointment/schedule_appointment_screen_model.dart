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
}
