import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'water_drank.g.dart';

@HiveType()
class WaterDrank {
  @HiveField(0)
  int ml;

  @HiveField(1)
  DateTime dateTime;

  WaterDrank({
    @required this.ml,
    @required this.dateTime,
  });

}