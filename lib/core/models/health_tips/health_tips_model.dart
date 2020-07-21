import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class HealthTip {
  final int id;
  final String tip;

  HealthTip({this.id, this.tip});

  factory HealthTip.fromJson(Map<String, dynamic> json) {
    return HealthTip(id: json['id'], tip: json['tip']);
  }
}

class HealthTipsService {
  Future<String> _loadAStudentAsset() async {
    return await rootBundle.loadString('images/health_tips.json');
  }

  Future<HealthTip> fetchHealthTip() async {
    Random random = Random();
    int id = random.nextInt(45) + 1;
    String jsonString = await _loadAStudentAsset();
    final jsonResponse = json.decode(jsonString);
    List<HealthTip> tips =
        jsonResponse.map((i) => HealthTip.fromJson(i)).toList();
    print(tips[id].tip);
    return tips[id];
  }
}
