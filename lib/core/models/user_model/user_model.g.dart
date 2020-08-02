// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  User read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      pointsGainedFitness: fields[2] as int,
      pointsGainedMed: fields[3] as int,
      pointsGainedDiet: fields[4] as int,
      name: fields[0] as String,
      id: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.pointsGainedFitness)
      ..writeByte(3)
      ..write(obj.pointsGainedMed)
      ..writeByte(4)
      ..write(obj.pointsGainedDiet);
  }

  @override
  // TODO: implement typeId
  int get typeId => 6;
}
