import 'package:MedBuzz/core/models/health_tips/health_tips_model.dart';
import 'package:MedBuzz/core/models/user_model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class UserCrud extends ChangeNotifier {
  static const String _boxName = "userBoxName";
  bool _showHealthTip = true;
  bool get showHealthTip => _showHealthTip;

  HealthTip _tip;
  HealthTip get tip => _tip;
  DateTime _date;
  DateTime get date => _date;

  User _user = User(name: '');
  User get user => _user;

  void getuser() async {
    try {
      var box = await Hive.openBox<User>(_boxName);
      _user = box.values.toList()[0];
      // box.close();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> adduser(User usernew) async {
    var box = await Hive.openBox<User>(_boxName);

    await box.put('userName', usernew);
    box.close();

    notifyListeners();
  }

//this function retrieves a health tip after confirming a health tip hasn't been shown to user that day
  void getHealthTip() async {
    try {
      HealthTipsService healthTipsService = HealthTipsService();
      var box = await Hive.openBox('date');
      _date = box.get('date');

      if (_date == null) {
        _showHealthTip = true;
        _tip = await healthTipsService.fetchHealthTip();
        _date = DateTime.now();
        box.put('date', _date);
        notifyListeners();
        box.close();
        return;
      }
      if (_date.day != DateTime.now().day) {
        _showHealthTip = true;
        _tip = await healthTipsService.fetchHealthTip();
        _date = DateTime.now();
        box.put('date', _date);
        notifyListeners();
        box.close();
        return;
      }
      if (_date.day == DateTime.now().day) {
        _showHealthTip = false;
        notifyListeners();
      }
      box.close();
    } catch (e) {
      print(e);
    }
  }

  void toggleShowTips() {
    _showHealthTip = !_showHealthTip;
    notifyListeners();
  }

  Future<void> edituser(User usernew) async {
    try {
      var box = await Hive.openBox<User>(_boxName);
      await box.put(_user.id, usernew);
      _user = box.values.toList()[0];

      box.close();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  User get newuser => _user;
}
