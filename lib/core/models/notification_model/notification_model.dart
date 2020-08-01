import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType()
class NotificationModel {
  @HiveField(0)
  final String reminderType;

  @HiveField(1)
  final String reminderId;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final DateTime dateTime;

  @HiveField(4)
  final bool isDone;

  @HiveField(5)
  final bool isSkipped;

  NotificationModel(
      //other fields can be marked required depending on requirements
      {
    this.isDone = false,
    this.isSkipped = false,
    this.reminderType,
    this.reminderId,
    this.dateTime,
    this.id,
  });
}
