import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:MedBuzz/main.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/schedule_appointment_reminder_screen.dart';

class AppointmentNotificationManager {
  var flutterLocalNotificationsPlugin;

  AppointmentNotificationManager() {
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

  void showAppointmentNotificationDaily(
      {int id, String title, String body, DateTime time}) async {
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, time, getPlatformChannelSpecfics(id));
    print(
        'Notification Succesfully Scheduled at ${time.toString()} with id of $id');
  }

  void showAppointmentAtSpecifiedInterval(
      {int id, String title, String body, RepeatInterval interval}) async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
        id, title, body, interval, getPlatformChannelSpecfics(id));
    print('Notification Succesfully Scheduled at an interval with id of $id');
  }

  Future<List<PendingNotificationRequest>> showEg() async {
    var pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print(pendingNotificationRequests);
  }

  void showAppointmentWeekdayAtTime(
      {int id,
      String title,
      String body,
      Day day,
      Time time,
      String tone}) async {
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        id, title, body, day, time, getPlatformChannelSpecfics(id));
    print(
        'Notification Succesfully Scheduled at an Weekday and Time with id of $id');
  }

  void showAppointmentNotificationOnce(
      int id, String title, String body, DateTime time,
      {String tone}) async {
    await flutterLocalNotificationsPlugin.schedule(
        id, title, body, time, getPlatformChannelSpecfics(id, toneName: tone));
    print(
        'Notification Succesfully Scheduled at ${time.toString()} with id of $id');

    //     int id, String title, String body, List<int> selectedTime) async {
    // var time = new Time(selectedTime[0], selectedTime[1], 0);
    // await flutterLocalNotificationsPlugin.schedule(
    //     id, title, body, time, getPlatformChannelSpecfics(id));
    // print(
    //     'Notification Succesfully Scheduled at ${time.toString()} with id of $id');
  }

  getPlatformChannelSpecfics(int id, {String toneName}) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '$id', 'your channel name', 'your channel description',
        importance: Importance.Max,
        priority: Priority.High,
        sound: toneName.isNotEmpty
            ? RawResourceAndroidNotificationSound(toneName)
            : null,
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
          builder: (context) => ScheduleAppointmentScreen(payload: payload)),
    );
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
    print('Notification with id: $notificationId been removed successfully');
  }
}
