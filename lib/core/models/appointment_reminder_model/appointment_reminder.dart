import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'appointment_reminder.g.dart';

@HiveType()
class Appointment {
  @HiveField(0)
  final String dateTime;
  @HiveField(1)
  final String appointmentType;
  @HiveField(2)
  final String note;
  @HiveField(3)
  final DateTime date;

  Appointment(
      {this.dateTime,
      @required this.appointmentType,
      this.note,
      @required this.date});
}
