import 'package:hive/hive.dart';

part 'fitness_reminder.g.dart';

@HiveType()
class FitnessReminder {
  @HiveField(0)
  int index;

  @HiveField(1)
  String name;

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

  FitnessReminder(
      {this.index,
      this.name,
      this.fitnesstype,
      this.fitnessfreq,
      this.activityTime,
      this.minsperday,
      this.startDate,
      this.endDate,
      this.id});
}
