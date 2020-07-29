import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NotificationToneModel extends ChangeNotifier {
  AssetsAudioPlayer player = AssetsAudioPlayer.newPlayer();
  static const String _boxName = "tonesBox";
  static const String _key = "tone";
  bool _isClassic = false;
  bool _isDream = false;
  bool _isDrizzle = false;
  bool _isEnchantment = false;
  bool _isSynthwave = false;
  bool _isBell = false;

  bool get isClassic => _isClassic;
  bool get isDream => _isDream;
  bool get isDrizzle => _isDrizzle;
  bool get isEnchantment => _isEnchantment;
  bool get isSynthwave => _isSynthwave;
  bool get isBell => _isBell;

  List<String> _tones = [
    "Classic Alarm",
    "Dream",
    "Drizzle",
    "Enchantment",
    "Synthwave",
    "Twin Bell"
  ];
  List<String> get tones => _tones;

  void _toggleSelected(String toneName) {
    switch (toneName) {
      case "Classic Alarm":
        _isClassic = true;
        _isBell = false;
        _isDream = false;
        _isDrizzle = false;
        _isEnchantment = false;
        _isSynthwave = false;
        notifyListeners();
        break;
      case "Dream":
        _isClassic = false;
        _isBell = false;
        _isDream = true;
        _isDrizzle = false;
        _isEnchantment = false;
        _isSynthwave = false;
        notifyListeners();
        break;
      case "Drizzle":
        _isClassic = false;
        _isBell = false;
        _isDream = false;
        _isDrizzle = true;
        _isEnchantment = false;
        _isSynthwave = false;
        notifyListeners();
        break;
      case "Enchantment":
        _isClassic = false;
        _isBell = false;
        _isDream = false;
        _isDrizzle = false;
        _isEnchantment = true;
        _isSynthwave = false;
        notifyListeners();
        break;
      case "Synthwave":
        _isClassic = false;
        _isBell = false;
        _isDream = false;
        _isDrizzle = false;
        _isEnchantment = false;
        _isSynthwave = true;
        notifyListeners();
        break;
      case "Twin Bell":
        _isClassic = false;
        _isBell = true;
        _isDream = false;
        _isDrizzle = false;
        _isEnchantment = false;
        _isSynthwave = false;
        notifyListeners();
        break;
    }
  }

  void onTap(String toneName) {
    player.pause();
    player.open(
      Audio("assets/$toneName.ogg.oga"),
      autoStart: true,
      showNotification: true,
    );
  }

  void pause() {
    player.pause();
  }

  void saveNotificationTone(String toneName) async {
    try {
      var box = await Hive.openBox(_boxName);
      await box.put(_key, toneName);
      _toggleSelected(toneName);
      box.close();
    } catch (e) {
      print(e);
    }
  }

  Future<String> getSavedNotificationTone() async {
    try {
      var box = await Hive.openBox(_boxName);
      String tone = box.get(_key);
      box.close();
      return tone;
    } catch (e) {
      print(e);
      return '';
    }
  }
}
