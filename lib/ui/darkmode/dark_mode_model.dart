import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'package:MedBuzz/ui/app_theme/app_theme_dark.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DarkModeModel extends ChangeNotifier {
  ThemeData _appTheme = appThemeLight;
  bool _isDark = false;
  ThemeData get appTheme => _appTheme;
  bool get isDarkMode => _isDark;

  void toggleAppTheme() async {
    _isDark = !_isDark;
    var box = await Hive.openBox('onboarding');
    if (_isDark) {
      _appTheme = appThemeDark;
      box.put('isDark', _isDark);

      notifyListeners();
    } else {
      _appTheme = appThemeLight;
      box.put('isDark', _isDark);
      notifyListeners();
    }
  }

  void setAppTheme() async {
    try {
      var box = await Hive.openBox('onboarding');
      bool isDark = box.get('isDark') ?? false;
      if (isDark) {
        _appTheme = appThemeDark;
        notifyListeners();
      } else {
        _appTheme = appThemeLight;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
