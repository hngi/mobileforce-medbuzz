import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType()
class User {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String id;

  User(
      //other fields can be marked required depending on requirements
      {this.name,
      this.id});
}
