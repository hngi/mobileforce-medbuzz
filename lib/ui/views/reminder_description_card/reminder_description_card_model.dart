import 'package:MedBuzz/core/database/diet_reminderDB.dart';
import 'package:MedBuzz/core/database/fitness_reminder.dart';
import 'package:MedBuzz/core/database/user_db.dart';
import 'package:MedBuzz/core/models/appointment_reminder_model/appointment_reminder.dart';
import 'package:MedBuzz/core/models/badge_model.dart';
import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:MedBuzz/core/models/fitness_reminder_model/fitness_reminder.dart';
import 'package:MedBuzz/core/models/medication_reminder_model/medication_reminder.dart';
import 'package:MedBuzz/core/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/models/diet_reminder/diet_reminder.dart';
import '../../../core/models/diet_reminder/diet_reminder.dart';
import '../../../core/models/diet_reminder/diet_reminder.dart';
import '../../../core/models/fitness_reminder_model/fitness_reminder.dart';
import '../../../core/models/fitness_reminder_model/fitness_reminder.dart';

class ReminderDescriptionCardModel extends ChangeNotifier {
  final String _key = 'points';

  // void editReminder(
  //     dynamic model, BuildContext context, bool isSkipped, bool isDone) {
  //   var fitModel = Provider.of<FitnessReminderCRUD>(context);
  //   var dietModel = Provider.of<DietReminderDB>(context);

  //   if (model is DietModel) {
  //     dietModel.editDiet(
  //         diet: DietModel(
  //             id: model.id,
  //             endDate: model.endDate,
  //             secondDietName: model.secondDietName,
  //             secondTime: model.secondTime,
  //             thirdDietName: model.thirdDietName,
  //             thirdTime: model.thirdTime,
  //             foodClasses: model.foodClasses,
  //             dietName: model.dietName,
  //             time: model.time,
  //             startDate: model.startDate,
  //             description: model.description,
  //             isDone: isDone,
  //             isSkipped: isSkipped));
  //     dietModel.getAlldiets();

  //     return;
  //   }
  //   if (model is FitnessReminder) {
  //     fitModel.editReminder(FitnessReminder(
  //         activityTime: model.activityTime,
  //         index: model.index,
  //         id: model.id,
  //         minsperday: model.minsperday,
  //         isDone: isDone,
  //         isSkipped: isSkipped,
  //         fitnessfreq: model.fitnessfreq,
  //         fitnesstype: model.fitnesstype,
  //         startDate: model.startDate,
  //         endDate: model.endDate));
  //     fitModel.getReminders();
  //   }
  // }

  void onDoneTap(dynamic model, BuildContext context) {
    return model is DietModel
        ? onDoneTapDiet(context, model)
        : onDoneTapFitness(context, model);
  }

  void onSkipTap(dynamic model, BuildContext context) {
    return model is DietModel
        ? onSkipTapDiet(context, model)
        : onSkipTapFitness(context, model);
  }

  String getPoints(dynamic model) {
    return model is DietModel
        ? '$totalPointsDiet/$nextBenchMarkDiet'
        : '$totalPointsFitness/$nextBenchMarkFitness';
  }

  String getReminderName(dynamic model) {
    return model is Appointment
        ? model.appointmentType
        : model is DietModel
            ? model.dietName
            : model is FitnessReminder
                ? model.fitnesstype
                : model is MedicationReminder
                    ? model.drugName
                    : 'Water Tracker';
  }

  String getImage(dynamic model, BuildContext context) {
    var fitnessModel = Provider.of<FitnessReminderCRUD>(context);
    return model is Appointment
        ? "images/calender.png"
        : model is DietModel
            ? "images/foood.png"
            : model is FitnessReminder
                ? fitnessModel.activityType[model.index]
                : model is MedicationReminder
                    ? "images/drugoutline.png"
                    : 'images/dropoutline.png';
  }

  String _formatDate(DateTime date) {
    return DateFormat.yMMMMd().format(date);
  }

  String _formatTime(List<int> time, BuildContext context) {
    return TimeOfDay(hour: time[0], minute: time[1]).format(context);
  }

  String getTime(dynamic model, BuildContext context) {
    return model is Appointment
        ? _formatTime(model.time, context)
        : model is DietModel
            ? _formatTime(model.time, context)
            : model is FitnessReminder
                ? 'For ${model.minsperday} minutes'
                : _formatTime(model.time, context);
  }

  String getDate(dynamic model) {
    return model is Appointment
        ? _formatDate(model.date)
        : model is DietModel
            ? _formatDate(model.startDate)
            : model is FitnessReminder
                ? _formatDate(model.startDate)
                : _formatDate(model.startAt);
  }

  DateTime getTimeField(model) {
    return model is Appointment
        ? model.date
        : model is DietModel
            ? model.startDate
            : model is FitnessReminder
                ? model.startDate
                : model is MedicationReminder ? model.startAt : model.dateTime;
  }

  int _totalPointsFitness = 0;
  int get totalPointsFitness => _totalPointsFitness;
  List _benchmarks = badges;

  int _nextBenchMarkFitness = 50;
  int get nextBenchMarkFitness => _nextBenchMarkFitness;
  final String _boxNameFitness = 'fitnessPoints';

  void onSkipTapFitness(
      BuildContext context, FitnessReminder fitnessReminder) async {
    try {
      var updatedFitnessReminder = FitnessReminder(
        activityTime: fitnessReminder.activityTime,
        description: fitnessReminder.description,
        endDate: fitnessReminder.endDate,
        fitnessfreq: fitnessReminder.fitnessfreq,
        fitnesstype: fitnessReminder.fitnesstype,
        id: fitnessReminder.id,
        index: fitnessReminder.index,
        isDone: false,
        isSkipped: true,
        minsperday: fitnessReminder.minsperday,
        startDate: fitnessReminder.startDate,
      );
      var box = await Hive.openBox(_boxNameFitness);
      await box.put(fitnessReminder.id, updatedFitnessReminder);
    } catch (e) {
      print(e);
    }
  }

  void onDoneTapFitness(
      BuildContext context, FitnessReminder fitnessReminder) async {
    var model = Provider.of<UserCrud>(context);
    try {
      var _userBox = await Hive.openBox<User>("userBoxName");
      var _user = _userBox.values.toList()[0];
      var updatedFitnessReminder = FitnessReminder(
        activityTime: fitnessReminder.activityTime,
        description: fitnessReminder.description,
        endDate: fitnessReminder.endDate,
        fitnessfreq: fitnessReminder.fitnessfreq,
        fitnesstype: fitnessReminder.fitnesstype,
        id: fitnessReminder.id,
        index: fitnessReminder.index,
        isDone: true,
        isSkipped: false,
        minsperday: fitnessReminder.minsperday,
        startDate: fitnessReminder.startDate,
      );
      var box = await Hive.openBox(_boxNameFitness);
      int points = box.get(_key);
      await box.put(fitnessReminder.id, updatedFitnessReminder);
      if (points == null) {
        box.put(_key, 5);
        _totalPointsFitness = 5;
        _nextBenchMarkFitness = _benchmarks[0].points;
        model.adduser(User(
            name: _user.name,
            pointsGainedDiet: _user.pointsGainedDiet,
            pointsGainedMed: _user.pointsGainedMed,
            id: _user.id,
            pointsGainedFitness: _totalPointsFitness));
        notifyListeners();
        return;
      } else {
        box.put(_key, points + 5);
        _totalPointsFitness = points + 5;
        _nextBenchMarkFitness = _getNextBenchmark(_totalPointsFitness);
        notifyListeners();
      }
      box.close();
    } catch (e) {
      print(e);
    }
  }

  int _totalPointsDiet = 0;
  int get totalPointsDiet => _totalPointsDiet;

  int _nextBenchMarkDiet = 50;
  int get nextBenchMarkDiet => _nextBenchMarkDiet;
  final String _boxNameDiet = 'dietPoints';

  void onSkipTapDiet(BuildContext context, DietModel dietModel) async {
    try {
      var updatedDietModel = DietModel(
        dietName: dietModel.dietName,
        time: dietModel.time,
        startDate: dietModel.startDate,
        isDone: false,
        isSkipped: true,
        description: dietModel.description,
        endDate: dietModel.endDate,
        foodClasses: dietModel.foodClasses,
        id: dietModel.id,
        secondDietName: dietModel.secondDietName,
        secondTime: dietModel.secondTime,
        thirdDietName: dietModel.thirdDietName,
        thirdTime: dietModel.thirdTime,
      );
      var box = await Hive.openBox(_boxNameDiet);
      await box.put(dietModel.id, updatedDietModel);
    } catch (e) {
      print(e);
    }
  }

  void onDoneTapDiet(BuildContext context, DietModel dietModel) async {
    var model = Provider.of<UserCrud>(context);
    try {
      var _userBox = await Hive.openBox<User>("userBoxName");
      var _user = _userBox.values.toList()[0];
      var updatedDietModel = DietModel(
        dietName: dietModel.dietName,
        time: dietModel.time,
        startDate: dietModel.startDate,
        isDone: true,
        isSkipped: false,
        description: dietModel.description,
        endDate: dietModel.endDate,
        foodClasses: dietModel.foodClasses,
        id: dietModel.id,
        secondDietName: dietModel.secondDietName,
        secondTime: dietModel.secondTime,
        thirdDietName: dietModel.thirdDietName,
        thirdTime: dietModel.thirdTime,
      );
      var box = await Hive.openBox(_boxNameDiet);
      await box.put(dietModel.id, updatedDietModel);
      int points = box.get(_key);
      if (points == null) {
        box.put(_key, 5);
        _totalPointsDiet = 5;
        _nextBenchMarkDiet = _benchmarks[0].points;
        model.adduser(User(
            name: _user.name,
            pointsGainedMed: _user.pointsGainedMed,
            pointsGainedFitness: _user.pointsGainedFitness,
            id: _user.id,
            pointsGainedDiet: _totalPointsDiet));
        notifyListeners();
        return;
      } else {
        box.put(_key, points + 5);
        _totalPointsDiet = points + 5;
        _nextBenchMarkDiet = _getNextBenchmark(_totalPointsDiet);
        notifyListeners();
      }
      print('$_totalPointsDiet/$_nextBenchMarkDiet');
      box.close();
    } catch (e) {
      print(e);
    }
  }

  //this should be executed once when the app's lifecycle is destroyed and relaunched
//so as to update fields in this model with persistent data
  void loadPointsFromDb() async {
    try {
      var _fitnessBox = await Hive.openBox(_boxNameFitness);
      _totalPointsFitness = _fitnessBox.get(_key) ?? 0;
      var _dietBox = await Hive.openBox(_boxNameDiet);
      _totalPointsDiet = _dietBox.get(_key) ?? 0;
      _nextBenchMarkFitness = _getNextBenchmark(_totalPointsFitness);
      _nextBenchMarkDiet = _getNextBenchmark(_totalPointsDiet);

      _fitnessBox.close();
      _dietBox.close();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  int _getNextBenchmark(int points) {
    if (points < 50) {
      return _nextBenchMarkDiet = _benchmarks[0].points;
    }
    if (points > 50 && points < 100) {
      return _benchmarks[1].points;
    }
    if (points > 100 && points < 150) {
      return _benchmarks[2].points;
    }
    if (points > 150 && points < 200) {
      return _benchmarks[3].points;
    }
    if (points > 200 && points < 250) {
      return _benchmarks[4].points;
    }
    if (points > 250 && points < 300) {
      return _benchmarks[5].points;
    }
    if (points > 300 && points < 350) {
      return _benchmarks[6].points;
    }
    if (points > 350 && points < 400) {
      return _benchmarks[7].points;
    }
    if (points > 400 && points <= 450) {
      return _benchmarks[8].points;
    }
    return _benchmarks[8].points;
  }
}
