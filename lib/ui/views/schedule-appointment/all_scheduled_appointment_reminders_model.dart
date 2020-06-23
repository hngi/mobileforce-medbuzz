import 'package:flutter/material.dart';

class MenuItem {
  String menuValue;

  MenuItem(this.menuValue);
}

final List<MenuItem> menuitems = [
  MenuItem("Edit"),
  MenuItem("Delete"),
];
//class TodaysDate {
//  String month = 'July';
//  int dateno = 12;
//  String day = 'Thurs';
//
//  TodaysDate(this.month, this.dateno, this.day);
//}

// enum _reminderState {Completed, Skipped, Upcoming}

//// Future action to return reminder state
//for each ListItem {
//  if (DateAndDay > Date.time(now)) {
//    print('Reminder is Completed.');
//    else{
//      print('Reminder was Skipped');
//}
//  } else {
//    print('Reminder is Upcoming');
//}
//
//}
