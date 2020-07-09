// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FitnessReminderAdapter extends TypeAdapter<FitnessReminder> {
  @override
  int get typeId => 3;
  @override
  FitnessReminder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FitnessReminder(
      index: fields[0] as int,
      name: fields[1] as String,
      fitnesstype: fields[2] as String,
      fitnessfreq: fields[3] as String,
      activityTime: (fields[4] as List)?.cast<int>(),
      minsperday: fields[5] as int,
      startDate: fields[6] as DateTime,
      endDate: fields[7] as DateTime,
      id: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FitnessReminder obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.fitnesstype)
      ..writeByte(3)
      ..write(obj.fitnessfreq)
      ..writeByte(4)
      ..write(obj.activityTime)
      ..writeByte(5)
      ..write(obj.minsperday)
      ..writeByte(6)
      ..write(obj.startDate)
      ..writeByte(7)
      ..write(obj.endDate)
      ..writeByte(8)
      ..write(obj.id);
  }
}
