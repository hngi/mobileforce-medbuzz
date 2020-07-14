import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'water_reminder.g.dart';

@HiveType()
class WaterReminder {
  @HiveField(0)
  int ml;

  @HiveField(1)
  DateTime startTime;

  @HiveField(2)
  String id;

  @HiveField(3)
  bool isTaken;

  @HiveField(4)
  bool isSkipped;

  @HiveField(5)
  String description;

  @HiveField(6)
  DateTime endTime;

  @HiveField(7)
  int interval;

  WaterReminder({
    @required this.ml,
    @required this.startTime,
    @required this.id,
    this.isTaken = false,
    this.isSkipped = false,
    this.description,
    @required this.endTime,
    @required this.interval,
  });
}
