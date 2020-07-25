import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType()
class NotificationModel {
  @HiveField(0)
  final String reminderType;

  @HiveField(7)
  final String reminderId;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final DateTime endTime;

  @HiveField(4)
  final bool isDone;

  @HiveField(5)
  final bool isSkipped;

  @HiveField(6)
  final String recurrence;

  NotificationModel(
      //other fields can be marked required depending on requirements
      {this.isSkipped = false,
      this.isDone = false,
      this.endTime,
      this.reminderType,
      this.reminderId,
      this.dateTime,
      this.id,
      this.recurrence});
}
