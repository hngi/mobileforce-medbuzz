// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_drank.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterDrankAdapter extends TypeAdapter<WaterDrank> {
  @override
  WaterDrank read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaterDrank(
      ml: fields[0] as int,
      dateTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WaterDrank obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.ml)
      ..writeByte(1)
      ..write(obj.dateTime);
  }

  @override
  // TODO: implement typeId
  int get typeId => 7;
}
