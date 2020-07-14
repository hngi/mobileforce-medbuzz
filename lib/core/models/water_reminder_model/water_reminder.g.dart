// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterReminderAdapter extends TypeAdapter<WaterReminder> {
  @override
  int get typeId => 8;
  @override
  WaterReminder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaterReminder(
      ml: fields[0] as int,
      dateTime: fields[1] as DateTime,
      id: fields[2] as String,
      isTaken: fields[3] as bool,
      isSkipped: fields[4] as bool,
      description: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WaterReminder obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.ml)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.isTaken)
      ..writeByte(4)
      ..write(obj.isSkipped)
      ..writeByte(5)
      ..write(obj.description);
  }
}
