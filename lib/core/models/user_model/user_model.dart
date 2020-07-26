import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType()
class User {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final int pointsGainedFitness;
  @HiveField(3)
  final int pointsGainedMed;
  @HiveField(4)
  final int pointsGainedDiet;

  User(
      //other fields can be marked required depending on requirements
      {this.pointsGainedFitness=0,
      this.pointsGainedMed=0,
      this.pointsGainedDiet=0,
      this.name,
      this.id});
}
