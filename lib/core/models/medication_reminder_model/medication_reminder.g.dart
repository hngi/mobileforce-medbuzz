// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicationReminderAdapter extends TypeAdapter<MedicationReminder> {
  @override
  MedicationReminder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicationReminder(
      drugName: fields[0] as String,
      drugType: fields[1] as String,
      frequency: fields[2] as String,
      firstTime: (fields[3] as List)?.cast<int>(),
      secondTime: (fields[4] as List)?.cast<int>(),
      thirdTime: (fields[5] as List)?.cast<int>(),
      dosage: fields[6] as int,
      startAt: fields[7] as DateTime,
      endAt: fields[8] as DateTime,
      isDone: fields[12] as bool,
      isSkipped: fields[13] as bool,
      index: fields[9] as String,
      id: fields[10] as String,
      description: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MedicationReminder obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.drugName)
      ..writeByte(1)
      ..write(obj.drugType)
      ..writeByte(2)
      ..write(obj.frequency)
      ..writeByte(3)
      ..write(obj.firstTime)
      ..writeByte(4)
      ..write(obj.secondTime)
      ..writeByte(5)
      ..write(obj.thirdTime)
      ..writeByte(6)
      ..write(obj.dosage)
      ..writeByte(7)
      ..write(obj.startAt)
      ..writeByte(8)
      ..write(obj.endAt)
      ..writeByte(9)
      ..write(obj.index)
      ..writeByte(10)
      ..write(obj.id)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.isDone)
      ..writeByte(13)
      ..write(obj.isSkipped);
  }

  @override
  // TODO: implement typeId
  int get typeId => 15;
}
