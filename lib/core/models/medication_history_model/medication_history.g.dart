// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicationHistoryAdapter extends TypeAdapter<MedicationHistory> {
  @override
  MedicationHistory read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicationHistory(
      drugName: fields[0] as String,
      drugType: fields[1] as String,
      frequency: fields[2] as String,
      firstTime: (fields[3] as List)?.cast<int>(),
      secondTime: (fields[4] as List)?.cast<int>(),
      thirdTime: (fields[5] as List)?.cast<int>(),
      dosage: fields[6] as int,
      startAt: fields[7] as DateTime,
      endAt: fields[8] as DateTime,
      index: fields[9] as String,
      id: fields[10] as String,
      description: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MedicationHistory obj) {
    writer
      ..writeByte(12)
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
      ..write(obj.description);
  }

  @override
  // TODO: implement typeId
  int get typeId => 4;
}
