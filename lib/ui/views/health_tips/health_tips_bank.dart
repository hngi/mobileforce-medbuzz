import 'package:MedBuzz/ui/views/health_tips/health_tips.dart';
class HealthTipsBank {


  List<Tips> healthTips = [
    Tips('Eat Healthy!',
        'Eat good food and fruits to keep you healthy. Drink a lot of water too.')
  ];

  int id = 0;

  String getTipsTitle() {
    return healthTips[id].title;
  }

  String getTip() {
    return healthTips[id].tip;
  }
}