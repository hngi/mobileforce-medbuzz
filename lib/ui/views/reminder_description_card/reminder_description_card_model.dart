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

class ReminderDescriptionCardModel extends ChangeNotifier {
  final String _key = 'points';

  void onDoneTap(dynamic model, BuildContext context) {
    return model is DietModel
        ? onDoneTapDiet(context)
        : onDoneTapFitness(context);
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

  int _totalPointsFitness = 0;
  int get totalPointsFitness => _totalPointsFitness;
  List _benchmarks = badges;

  int _nextBenchMarkFitness = 50;
  int get nextBenchMarkFitness => _nextBenchMarkFitness;
  final String _boxNameFitness = 'fitnessPoints';

  void onDoneTapFitness(BuildContext context) async {
    var model = Provider.of<UserCrud>(context);
    try {
      var _userBox = await Hive.openBox<User>("userBoxName");
      var _user = _userBox.values.toList()[0];
      var box = await Hive.openBox(_boxNameFitness);
      int points = box.get(_key);
      if (points == null) {
        box.put(_key, 5);
        _totalPointsFitness = 5;
        _nextBenchMarkFitness = _benchmarks[0].points;
        model.adduser(User(
            name: _user.name,
            id: _user.id,
            pointsGainedFitness: _totalPointsFitness));
        notifyListeners();
        box.close();
        return;
      } else {
        box.put(_key, points + 5);
        _totalPointsFitness = points + 5;
        notifyListeners();
        if (_totalPointsFitness < 50) {
          _nextBenchMarkFitness = _benchmarks[0].points;
          notifyListeners();
        }
        if (_totalPointsFitness > 50 && _totalPointsFitness < 100) {
          _nextBenchMarkFitness = _benchmarks[1].points;
          notifyListeners();
        }
        if (_totalPointsFitness > 100 && _totalPointsFitness < 150) {
          _nextBenchMarkFitness = _benchmarks[2].points;
          notifyListeners();
        }
        if (_totalPointsFitness > 150 && _totalPointsFitness < 200) {
          _nextBenchMarkFitness = _benchmarks[3].points;
          notifyListeners();
        }
        if (_totalPointsFitness > 200 && _totalPointsFitness < 250) {
          _nextBenchMarkFitness = _benchmarks[4].points;
          notifyListeners();
        }
        if (_totalPointsFitness > 250 && _totalPointsFitness < 300) {
          _nextBenchMarkFitness = _benchmarks[5].points;
          notifyListeners();
        }
        if (_totalPointsFitness > 300 && _totalPointsFitness < 350) {
          _nextBenchMarkFitness = _benchmarks[6].points;
          notifyListeners();
        }
        if (_totalPointsFitness > 350 && _totalPointsFitness < 400) {
          _nextBenchMarkFitness = _benchmarks[7].points;
          notifyListeners();
        }
        if (_totalPointsFitness > 400 && _totalPointsFitness <= 450) {
          _nextBenchMarkFitness = _benchmarks[8].points;
          notifyListeners();
        }
      }
      print('$_totalPointsFitness/$_nextBenchMarkFitness');
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

  void onDoneTapDiet(BuildContext context) async {
    var model = Provider.of<UserCrud>(context);
    try {
      var _userBox = await Hive.openBox<User>("userBoxName");
      var _user = _userBox.values.toList()[0];
      var box = await Hive.openBox(_boxNameDiet);
      int points = box.get(_key);
      if (points == null) {
        box.put(_key, 5);
        _totalPointsDiet = 5;
        _nextBenchMarkDiet = _benchmarks[0].points;
        model.adduser(User(
            name: _user.name,
            id: _user.id,
            pointsGainedDiet: _totalPointsDiet));
        notifyListeners();
        box.close();
        return;
      } else {
        box.put(_key, points + 5);
        _totalPointsDiet = points + 5;
        notifyListeners();
        if (_totalPointsDiet < 50) {
          _nextBenchMarkDiet = _benchmarks[0].points;
          notifyListeners();
        }
        if (_totalPointsDiet > 50 && _totalPointsDiet < 100) {
          _nextBenchMarkDiet = _benchmarks[1].points;
          notifyListeners();
        }
        if (_totalPointsDiet > 100 && _totalPointsDiet < 150) {
          _nextBenchMarkDiet = _benchmarks[2].points;
          notifyListeners();
        }
        if (_totalPointsDiet > 150 && _totalPointsDiet < 200) {
          _nextBenchMarkDiet = _benchmarks[3].points;
          notifyListeners();
        }
        if (_totalPointsDiet > 200 && _totalPointsDiet < 250) {
          _nextBenchMarkDiet = _benchmarks[4].points;
          notifyListeners();
        }
        if (_totalPointsDiet > 250 && _totalPointsDiet < 300) {
          _nextBenchMarkDiet = _benchmarks[5].points;
          notifyListeners();
        }
        if (_totalPointsDiet > 300 && _totalPointsDiet < 350) {
          _nextBenchMarkDiet = _benchmarks[6].points;
          notifyListeners();
        }
        if (_totalPointsDiet > 350 && _totalPointsDiet < 400) {
          _nextBenchMarkDiet = _benchmarks[7].points;
          notifyListeners();
        }
        if (_totalPointsDiet > 400 && _totalPointsDiet <= 450) {
          _nextBenchMarkDiet = _benchmarks[8].points;
          notifyListeners();
        }
      }
      print('$_totalPointsDiet/$_nextBenchMarkDiet');
      box.close();
    } catch (e) {
      print(e);
    }
  }
}
