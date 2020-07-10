import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'package:MedBuzz/ui/app_theme/app_theme_dark.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DarkModeModel extends ChangeNotifier {
  ThemeData _appTheme = appThemeLight;
  bool _isDark = false;
  ThemeData get appTheme => _appTheme;

  void toggleAppTheme() {
    if (_isDark) {
      _appTheme = appThemeDark;
      _isDark = !_isDark;
      notifyListeners();
    } else {
      _appTheme = appThemeLight;
      _isDark = !_isDark;
      notifyListeners();
    }
  }
}
