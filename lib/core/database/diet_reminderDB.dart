import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/diet_reminder/diet_reminder.dart';

//Crazelu renamed this as DietReminderDB for better disctinction
class DietReminderDB extends ChangeNotifier {
  // Hive box name

  static const String _boxname = "dietReminderBox";

  // List<DietModel> get pastDiets => this._pastDiets;
  // List<DietModel> get upcomingDiets => this._upcomingDiets;
  List<DietModel> _allDiets = [];
  List<DietModel> get allDiets => this._allDiets;

  // List<DietModel> _pastDiets = [];
  // List<DietModel> _upcomingDiets = [];

  void deleteDietReminders() async {
    try {
      var box = await Hive.openBox<DietModel>(_boxname);
      box.deleteFromDisk();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // get all diets

  void getAlldiets() async {
    var box = await Hive.openBox<DietModel>(_boxname);
    _allDiets = box.values.toList();
    // this._diet = box.values.toList();
    // print('number of diet reminders: ${this._diet.length}');
    //this logic is still faulty somehow
    // _pastDiets.clear();
    // _upcomingDiets.clear();
    // for (var i in _diet) {
    //   if (i.startDate.difference(DateTime.now()).inDays < 0) {
    //     _pastDiets.add(i);
    //   } else {
    //     _upcomingDiets.add(i);
    //   }
    // }
    notifyListeners();
  }

  // get a specific diet by it's index

  DietModel getDiet(index) {
    return _allDiets[index];
  }

  List<DietModel> get dietRemindersBasedOnDateTime {
    return _allDiets
        .where((reminder) => DateTime.now().day == reminder.startDate.day)
        .toList();
  }

  // add a  diet

  void addDiet(DietModel diet) async {
    var box = await Hive.openBox<DietModel>(_boxname);

    await box.put(diet.id, diet);

    _allDiets = box.values.toList();
    // print('here ${this._diet}');
    box.close();
    notifyListeners();
  }

  // void addMany(List<DietModel> diets) async {
  //   var box = await Hive.openBox<DietModel>(_boxname);
  //   diets.map((e) => null);

  //   await box.putAll(diet.id, diet);

  //   _allDiets = box.values.toList();
  //   // print('here ${this._diet}');
  //   box.close();
  //   notifyListeners();
  // }

  // delete a diet
  void deleteDiet(key) async {
    var box = await Hive.openBox<DietModel>(_boxname);

    _allDiets = box.values.toList();
    box.delete(key);
    box.close();
    // getAlldiets();
    notifyListeners();
  }

  // edit DIet

  void editDiet({DietModel diet}) async {
    var box = await Hive.openBox<DietModel>(_boxname);

    await box.put(diet.id, diet);

    _allDiets = box.values.toList();
    // getAlldiets();
    box.close();
    notifyListeners();
  }

  int getdietcount() {
    return _allDiets.length;
  }

  double getNumberOfDietsWithFoodClass(String className) {
    var result = _allDiets
        .where((element) =>
            element.isDone == true && element.foodClasses.contains(className))
        .toList()
        .length;
    // return 10.0;
    return result.toDouble();
  }
}
