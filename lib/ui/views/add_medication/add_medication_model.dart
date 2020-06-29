import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddMedication extends ChangeNotifier {
  int selectedIndex = 0;
  int dosage = 1;
  String currentSelectedValue = 'Once';
  bool isEditing = false;
  String drugName;
  var drugType = [
    'Injection',
    'Tablets',
    'Drops',
    'Pills',
    'Ointment',
    'Syrup',
    'Inhaler'
  ];
  final List<String> frequency = ['Once', 'Twice', 'Thrice'];
  List<String> images = [
    'images/injection.png',
    'images/tablets.png',
    'images/drops.png',
    'images/pills.png',
    'images/ointment.png',
    'images/syrup.png',
    'images/inhaler.png'
  ];
  TimeOfDay firstTime = TimeOfDay.now();
  TimeOfDay secondTime = TimeOfDay.now();
  TimeOfDay thirdTime = TimeOfDay.now();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  void onSelectedDrugImage(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void updateFirstTime(TimeOfDay selected) {
    this.firstTime = selected;
    notifyListeners();
  }

  void updateSecondTime(TimeOfDay selected) {
    this.secondTime = selected;
    notifyListeners();
  }

  void updateThirdTime(TimeOfDay selected) {
    this.thirdTime = selected;
    notifyListeners();
  }

  void incrementCounter() {
    dosage++;
    notifyListeners();
  }

  void decrementCounter() {
    if (dosage > 1) {
      dosage--;
    }
    notifyListeners();
  }

  void updateStartDate(DateTime selected) {
    this.startTime = selected;
    notifyListeners();
  }

  void updateEndDate(DateTime selected) {
    this.endTime = selected;
    notifyListeners();
  }

  void updateDrugName(String name) {
    drugName = name;
    notifyListeners();
  }
}
