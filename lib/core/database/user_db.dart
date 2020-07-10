import 'package:MedBuzz/core/models/user_model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class UserCrud extends ChangeNotifier {
  static const String _boxName = "userBoxName";

  User _user;

  void getuser() async {
    var box = await Hive.openBox<User>(_boxName);
    _user = box.get('userName');

    notifyListeners();
  }

  Future<void> adduser(User userNew) async {
    var box = await Hive.openBox<User>(_boxName);

    await box.put('userName', userNew);
    box.close();

    notifyListeners();
  }

  User get newuser => _user;
}
