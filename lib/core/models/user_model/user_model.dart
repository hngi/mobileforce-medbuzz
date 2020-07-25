import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType()
class User {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final int pointsGained;

  User(
      //other fields can be marked required depending on requirements
      {this.name,
      this.pointsGained = 0,
      this.id});
}
