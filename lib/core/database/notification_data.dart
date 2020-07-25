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

  void handleNotification(
      NotificationModel notificationModel, bool action) async {
    var newModel = NotificationModel(
      dateTime: notificationModel.dateTime,
      endTime: notificationModel.endTime,
      id: notificationModel.id,
      isSkipped: action == false ? true : false,
      isDone: action == true ? true : false,
      recurrence: notificationModel.recurrence,
      reminderId: notificationModel.reminderId,
      reminderType: notificationModel.reminderType,
    );

    var box = await Hive.openBox<NotificationModel>(_boxName);

    await box.put(newModel.id.toString(), newModel);
    _notifications = box.values.toList();
    box.close();

    notifyListeners();
  }

  List<NotificationModel> get currentNotifications {
    List<NotificationModel> result = [];
    _notifications.forEach((element) {
      //check if notification has start and end date or is just one time i.e only has startDate
      //then check if the notification has a daily recurrence, returns all for the present day
      if (element.recurrence == 'Daily') {
        if (element.dateTime.hour >= DateTime.now().hour) {
          result.add(element);
        }
      } else {
        if (element.dateTime.difference(DateTime.now()).inDays >= 0) {
          result.add(element);
        }
      }
    });
    return result;
  }

  List<NotificationModel> get currentWeeklyNotifications {
    List<NotificationModel> result = [];
    _notifications.forEach((element) {
      //check if notification has start and end date or is just one time i.e only has startDate
      //then check if the notification has a daily recurrence, returns all for the present day
      if (element.recurrence == 'Daily') {
        if (element.dateTime.hour >= DateTime.now().hour) {
          result.add(element);
        }
      } else {
        //checks across 7 days for weekly
        if (element.dateTime.difference(DateTime.now()).inDays >= 7) {
          result.add(element);
        }
      }
    });
    return result;
  }

  List<NotificationModel> get currentMonthlyNotifications {
    List<NotificationModel> result = [];
    _notifications.forEach((element) {
      //check if notification has start and end date or is just one time i.e only has startDate
      //then check if the notification has a daily recurrence, returns all for the present day
      if (element.recurrence == 'Daily') {
        if (element.dateTime.hour >= DateTime.now().hour) {
          result.add(element);
        }
      } else {
        //check if the same month and year
        if (element.dateTime.month == DateTime.now().month &&
            element.dateTime.year == DateTime.now().year) {
          result.add(element);
        }
      }
    });
    return result;
  }

  int get totalWaterPointsForTheWeek {
    //each water reminder notification is 5 points
    int progress = 0;
    var result = currentWeeklyNotifications
        .where((element) => element.reminderType == 'water-model')
        .toList();
    for (var i = 0; i < result.length; i++) {
      progress += 5;
    }

    return progress;
  }

  int get totalWaterPointsForTheMonth {
    //each water reminder notification is 5 points
    int progress = 0;
    currentMonthlyNotifications
        .where((element) => element.reminderType == 'water-model')
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalWaterCompletedPointsForTheWeek {
    //each water reminder notification is 5 points
    //this gets for only completed water notifications
    int progress = 0;
    currentWeeklyNotifications
        .where((element) =>
            element.reminderType == 'water-model' && element.isDone == true)
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalWaterCompletedPointsForTheMonth {
    //each water reminder notification is 5 points
    //this gets for only completed water notifications
    int progress = 0;
    currentMonthlyNotifications
        .where((element) =>
            element.reminderType == 'water-model' && element.isDone == true)
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalDietPointsForTheWeek {
    //each water reminder notification is 5 points
    int progress = 0;
    currentWeeklyNotifications
        .where((element) => element.reminderType == 'diet-model')
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalDietPointsForTheMonth {
    //each water reminder notification is 5 points
    int progress = 0;
    currentMonthlyNotifications
        .where((element) => element.reminderType == 'diet-model')
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalDietCompletedPointsForTheWeek {
    //each water reminder notification is 5 points
    //this gets for only completed water notifications
    int progress = 0;
    currentWeeklyNotifications
        .where((element) =>
            element.reminderType == 'diet-model' && element.isDone == true)
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalDietCompletedPointsForTheMonth {
    //each water reminder notification is 5 points
    //this gets for only completed water notifications
    int progress = 0;
    currentMonthlyNotifications
        .where((element) =>
            element.reminderType == 'diet-model' && element.isDone == true)
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalFitnessPointsForTheWeek {
    //each water reminder notification is 5 points
    int progress = 0;
    currentWeeklyNotifications
        .where((element) => element.reminderType == 'fitness-model')
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalFitnessPointsForTheMonth {
    //each water reminder notification is 5 points
    int progress = 0;
    currentMonthlyNotifications
        .where((element) => element.reminderType == 'fitness-model')
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalFitnessCompletedPointsForTheWeek {
    //each water reminder notification is 5 points
    //this gets for only completed water notifications
    int progress = 0;
    currentWeeklyNotifications
        .where((element) =>
            element.reminderType == 'fitness-model' && element.isDone == true)
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalFitnessCompletedPointsForTheMonth {
    //each water reminder notification is 5 points
    //this gets for only completed water notifications
    int progress = 0;
    currentMonthlyNotifications
        .where((element) =>
            element.reminderType == 'fitness-model' && element.isDone == true)
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalMedicationPointsForTheWeek {
    //each water reminder notification is 5 points
    int progress = 0;
    currentWeeklyNotifications
        .where((element) => element.reminderType == 'medication-model')
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalMedicationPointsForTheMonth {
    //each water reminder notification is 5 points
    int progress = 0;
    currentMonthlyNotifications
        .where((element) => element.reminderType == 'medication-model')
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalMedicationCompletedPointsForTheWeek {
    //each water reminder notification is 5 points
    //this gets for only completed water notifications
    int progress = 0;
    currentWeeklyNotifications
        .where((element) =>
            element.reminderType == 'medication-model' &&
            element.isDone == true)
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalMedicationCompletedPointsForTheMonth {
    //each water reminder notification is 5 points
    //this gets for only completed water notifications
    int progress = 0;
    currentMonthlyNotifications
        .where((element) =>
            element.reminderType == 'medication-model' &&
            element.isDone == true)
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalAppointmentPointsForTheWeek {
    //each water reminder notification is 5 points
    int progress = 0;
    currentWeeklyNotifications
        .where((element) => element.reminderType == 'appointment-model')
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalAppointmentPointsForTheMonth {
    //each water reminder notification is 5 points
    int progress = 0;
    currentMonthlyNotifications
        .where((element) => element.reminderType == 'appointment-model')
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalAppointmentCompletedPointsForTheWeek {
    //each water reminder notification is 5 points
    //this gets for only completed water notifications
    int progress = 0;
    currentWeeklyNotifications
        .where((element) =>
            element.reminderType == 'appointment-model' &&
            element.isDone == true)
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }

  int get totalAppointmentCompletedPointsForTheMonth {
    //each water reminder notification is 5 points
    //this gets for only completed water notifications
    int progress = 0;
    currentMonthlyNotifications
        .where((element) =>
            element.reminderType == 'appointment-model' &&
            element.isDone == true)
        .forEach((element) {
      progress += 5;
    });

    return progress;
  }
}
