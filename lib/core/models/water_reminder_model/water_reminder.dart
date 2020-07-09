import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'water_reminder.g.dart';

@HiveType()
class WaterReminder {
  @HiveField(0)
  int ml;

  @HiveField(1)
  DateTime dateTime;

  @HiveField(2)
  String id;

  @HiveField(3)
  bool isTaken;

  @HiveField(4)
  bool isSkipped;

  WaterReminder({
    @required this.ml,
    @required this.dateTime,
    @required this.id,
    this.isTaken = false,
    this.isSkipped = false,
  });
}
