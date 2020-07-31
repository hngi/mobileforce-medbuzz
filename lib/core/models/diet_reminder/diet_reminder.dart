import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

part 'diet_reminder.g.dart';

@HiveType()
class DietModel {
  @HiveField(0)
  final String dietName;
  @HiveField(1)
  final List<int> time;
  @HiveField(2)
  final DateTime startDate;

  // Incase this will be used for a three-square meal reminder, I'll include optional fields
  @HiveField(3)
  final String secondDietName;
  @HiveField(4)
  final String thirdDietName;
  @HiveField(5)
  final List<int> secondTime;
  @HiveField(6)
  final List<int> thirdTime;
  //optional end date, if not suppplied, notification should probably be set for just the start date
  @HiveField(7)
  final DateTime endDate;

  @HiveField(8)
  final String id;

  @HiveField(9)
  final String description;
  @HiveField(10)
  final List<String> foodClasses;
  @HiveField(11)
  final bool isDone;
  @HiveField(12)
  final bool isSkipped;

  @HiveField(13)
  String frequency;

  @HiveField(14)
  List<int> activityTime;

  @HiveField(15)
  int minsperday;

  DietModel(
      {@required this.dietName,
      @required this.time,
      @required this.startDate,
      this.secondDietName,
      this.isDone = false,
      this.isSkipped = false,
      this.thirdDietName,
      this.frequency,
      this.activityTime,
      this.minsperday,
      this.secondTime,
      this.thirdTime,
      this.endDate,
      this.id,
      this.description,
      this.foodClasses});
}
