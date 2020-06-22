import 'package:flutter/material.dart';

class FitnessModel{
  String name;
  String fitnesstype;
  String fitnessfreq;
  TimeOfDay activityTime;
  int minsperday;
  DateTime startDate;
  DateTime endDate;

  FitnessModel(this.name, this.fitnesstype, this.fitnessfreq, this.activityTime, this.minsperday, this.startDate, this.endDate);

}