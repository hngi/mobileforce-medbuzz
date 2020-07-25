import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType()
class NotificationModel {
  @HiveField(0)
  final String reminderType;

  @HiveField(0)
  final String reminderId;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final bool isClicked;

  NotificationModel(
      //other fields can be marked required depending on requirements
      {
    this.isClicked = false,
    this.reminderType,
    this.reminderId,
    this.dateTime,
    this.id,
  });
}
