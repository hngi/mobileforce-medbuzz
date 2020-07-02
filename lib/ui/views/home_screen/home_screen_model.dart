import 'package:flutter/cupertino.dart';

class HomeScreenModel extends ChangeNotifier {
  int _initialIndex = 0;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  int get initialIndex => _initialIndex;
  void updateCurrentIndex(int index) {
    this._currentIndex = index;
    notifyListeners();
  }
}
