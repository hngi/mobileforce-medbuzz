import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnackBar(BuildContext context,
      {String text: "Reminder can't be set in the past", bool success: false}) {
    Flushbar(
      icon: Icon(
        Icons.info_outline,
        size: Config.xMargin(context, 7.777),
        color: success ? Colors.green : Colors.red,
      ),
      message: text,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
