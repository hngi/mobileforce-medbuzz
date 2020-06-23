import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DietReminderModel extends ChangeNotifier {
  bool isVisible = true;

  //functionality for making the FAB appear and disappear when user scrolls
  void updateVisibility(bool visible) {
    this.isVisible = visible;
    notifyListeners();
  }
}
