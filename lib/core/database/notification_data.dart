import 'package:MedBuzz/core/models/notification_model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NotificationData extends ChangeNotifier {
  static const String _boxName = "notificationBox";

  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  void getNotifications() async {
    try {
      var box = await Hive.openBox<NotificationModel>(_boxName);

      _notifications = box.values.toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addNotification(NotificationModel notificationModel) async {
    var box = await Hive.openBox<NotificationModel>(_boxName);

    await box.put(notificationModel.id.toString(), notificationModel);

    //reinitialise water reminders after write operation
    _notifications = box.values.toList();

    // box.close();

    notifyListeners();
  }

  Future<void> deleteNotification(key) async {
    try {
      await Hive.openBox<NotificationModel>(_boxName)
          .then((value) => value.delete(key));

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAllNotifications() async {
    try {
      await Hive.openBox<NotificationModel>(_boxName).then((value) async {
        for (var item in _notifications) {
          await deleteNotification(item.dateTime.toString());
        }
      });

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void editWaterReminder(
      {NotificationModel notificationModel,
      String notificationModelKey}) async {
    var box = await Hive.openBox<NotificationModel>(_boxName);

    await box.put(notificationModel.id.toString(), notificationModel);

    _notifications = box.values.toList();
    box.close();

    // _activeWaterReminder = box.get(waterReminderKey);

    notifyListeners();
  }

  int get notificationCount {
    return _notifications.length;
  }
}
