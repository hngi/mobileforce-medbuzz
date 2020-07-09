// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentAdapter extends TypeAdapter<Appointment> {
  @override
  int get typeId => 0;
  @override
  Appointment read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Appointment(
      dateTime: fields[0] as String,
      appointmentType: fields[1] as String,
      note: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Appointment obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.appointmentType)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.date);
  }
}
