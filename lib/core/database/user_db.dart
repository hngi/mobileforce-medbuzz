import 'package:MedBuzz/core/models/user_model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class UserCrud extends ChangeNotifier {
  static const String _boxName = "userBoxName";

  User _user;
  User get user => _user;

  void getuser() async {
    var box = await Hive.openBox<User>(_boxName);
    _user = box.get('userName');
    box.close();
    notifyListeners();
  }

  void adduser(User user) async {
    var box = await Hive.openBox<User>(_boxName);

    await box.put('userName', user);
    box.close();

    notifyListeners();
  }
}
