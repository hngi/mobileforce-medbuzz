import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'medication_reminder.g.dart';

@HiveType()
class MedicationReminder {
  @HiveField(0)
  String drugName;

  @HiveField(1)
  String drugType;

  @HiveField(2)
  String frequency;

  @HiveField(3)
  List<int> firstTime;

  @HiveField(4)
  List<int> secondTime;

  @HiveField(5)
  List<int> thirdTime;

  @HiveField(6)
  int dosage;

  @HiveField(7)
  DateTime startAt;

  @HiveField(8)
  DateTime endAt;

  @HiveField(9)
  String index;

  @HiveField(10)
  int id;

  MedicationReminder(
      {this.drugName,
      this.drugType,
      this.frequency,
      this.firstTime,
      this.secondTime,
      this.thirdTime,
      this.dosage,
      this.startAt,
      this.endAt,
      this.index,
      this.id});
}
