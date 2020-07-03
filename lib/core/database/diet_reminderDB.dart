import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//Crazelu renamed this as DietReminderDB for better disctinction
class DietReminderDB extends ChangeNotifier{
  // Hive box name 

  static const String _boxname = "dietReminderBox";

  // Making an emptylist of diets 

  List<DietModel> _diet = [];

  // DietModel Object
  DietModel _dietModel;

  // get all diets

  void getAlldiets() async {
    var box = await Hive.openBox(_boxname);

    _diet = box.values.toList();

    notifyListeners();
  }

  // get a specific diet by it's index

  DietModel getDiet(index){
    return _diet[index];
  }

  // add a  diet 

  void addDiet(DietModel diet)async{
    var box = await Hive.openBox<DietModel>(_boxname);

    await box.add(diet);

    _diet = box.values.toList();
    box.close();

    notifyListeners();
  }

  // delete a diet 
  void deleteDiet(key) async{
    var box = await Hive.openBox<DietModel>(_boxname);

    _diet = box.values.toList();
    box.delete(key);
    box.close();

    notifyListeners();
  }

  // edit DIet 

  void editDiet({DietModel diet, int index})async{
    var box = await Hive.openBox<DietModel>(_boxname);

    box.putAt(index, diet);

    _diet = box.values.toList();
    box.close();
    notifyListeners();
  }

  int getdietcount(){
    return _diet.length;
  }
}