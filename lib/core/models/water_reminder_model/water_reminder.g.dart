// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterReminderAdapter extends TypeAdapter<WaterReminder> {
  @override
  WaterReminder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaterReminder(
      ml: fields[0] as int,
      dateTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WaterReminder obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.ml)
      ..writeByte(1)
      ..write(obj.dateTime);
  }

   @override

  int get typeId => 2;
}
