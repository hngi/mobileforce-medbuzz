import 'package:flutter/cupertino.dart';

class ConfirmOrSnoozeModel extends ChangeNotifier {
  String _drugName = 'Paracetamol';

  String get drugName => _drugName;

  // I don't know if this will be necessary but it is intended to get the drug name for a service
  void getDrugName() {
    //Get drug name to display on the page from a service and notifyListeners();
  }

  //Function to be invoked when the snooze button is pressed
  void onSnooze() {}

  //Function to be invoked when the done button is pressed
  void onDone() {}
}
