import 'package:MedBuzz/ui/views/add_medication/add_medication_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:MedBuzz/main.dart';

class DrugNotificationManager {
  var flutterLocalNotificationsPlugin;

  DrugNotificationManager() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  void initNotifications() {
    // initialise the plugin.
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void showDrugNotificationDaily(
      {int id, String title, String body, int hour, int minute}) async {
    var time = new Time(hour, minute, 0);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, time, getPlatformChannelSpecfics(id));
    print(
        'Notification Succesfully Scheduled at ${time.toString()} with id of $id');
  }

  getPlatformChannelSpecfics(int id) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '$id', 'your channel name', 'your channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'Fitness Reminder');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    return platformChannelSpecifics;
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return Future.value(1);
  }

  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
      MyApp.navigatorKey.currentState.context,
      MaterialPageRoute(
          builder: (context) => AddMedicationScreen(payload: payload)),
    );
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
    print('Notfication with id: $notificationId been removed successfully');
  }
}
