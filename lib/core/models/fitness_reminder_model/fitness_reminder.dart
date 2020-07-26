import 'package:hive/hive.dart';

part 'fitness_reminder.g.dart';

@HiveType()
class FitnessReminder {
  @HiveField(0)
  int index;

  @HiveField(1)
  String description;

  @HiveField(2)
  String fitnesstype;

  @HiveField(3)
  String fitnessfreq;

  @HiveField(4)
  List<int> activityTime;

  @HiveField(5)
  int minsperday;

  @HiveField(6)
  DateTime startDate;

  @HiveField(7)
  DateTime endDate;

  @HiveField(8)
  final String id;

  @HiveField(9)
  final bool isDone;
  @HiveField(10)
  final bool isSkipped;

  FitnessReminder(
      {this.index,
      this.description,
      this.fitnesstype,
      this.fitnessfreq,
      this.activityTime,
      this.minsperday,
      this.isDone = false,
      this.isSkipped = false,
      this.startDate,
      this.endDate,
      this.id});
}
