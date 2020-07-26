import 'package:MedBuzz/core/database/user_db.dart';
import 'package:MedBuzz/ui/views/medication_reminders/all_medications_reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewAllReminderModel extends ChangeNotifier {
  String getGreeting(BuildContext context) {
    var userName = Provider.of<UserCrud>(context).user.name;
    return 'Good job $userName!';
  }

  List<dynamic> allNotifications = [];
//This function returns a string that contains details of how many days user has succesfully logged their stats
  String getUserProgress() {
    return 'You  have logged your stats succesfully everyday in the last 7 days!';
  }
}
