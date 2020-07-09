import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//Crazelu renamed this as DietReminderDB for better disctinction
class DietReminderDB extends ChangeNotifier {
  // Hive box name

  static const String _boxname = "dietReminderBox";

  // Making an emptylist of diets

  List<DietModel> _diet = [];

  List<DietModel> get pastDiets => this._pastDiets;
  List<DietModel> get upcomingDiets => this._upcomingDiets;

  List<DietModel> _pastDiets = [];
  List<DietModel> _upcomingDiets = [];

  // get all diets

  void getAlldiets() async {
    var box = await Hive.openBox<DietModel>(_boxname);
    this._diet = box.values.toList();
    print('number of diet reminders: ${this._diet.length}');
    //this logic is still faulty somehow
    _pastDiets.clear();
    _upcomingDiets.clear();
    for (var i in _diet) {
      if (i.startDate.difference(DateTime.now()).inDays < 0) {
        _pastDiets.add(i);
      } else {
        _upcomingDiets.add(i);
      }
    }
    notifyListeners();
  }

  // get a specific diet by it's index

  DietModel getDiet(index) {
    return this._diet[index];
  }

  // add a  diet

  void addDiet(DietModel diet) async {
    var box = await Hive.openBox<DietModel>(_boxname);

    await box.put(diet.id, diet);

    this._diet = box.values.toList();
    print('here ${this._diet}');
    box.close();
    notifyListeners();
  }

  // delete a diet
  void deleteDiet(key) async {
    var box = await Hive.openBox<DietModel>(_boxname);

    this._diet = box.values.toList();
    box.delete(key);
    box.close();
    getAlldiets();
    notifyListeners();
  }

  // edit DIet

  void editDiet({DietModel diet}) async {
    var box = await Hive.openBox<DietModel>(_boxname);

    box.put(diet.id, diet);

    this._diet = box.values.toList();
    box.close();
    getAlldiets();
    notifyListeners();
  }

  int getdietcount() {
    return this._diet.length;
  }
}
