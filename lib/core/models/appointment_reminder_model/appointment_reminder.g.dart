// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentAdapter extends TypeAdapter<Appointment> {
  @override
  Appointment read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Appointment(
      appointmentMonth: fields[0] as DateTime,
      appointmentDay: fields[1] as DateTime,
      appointmentTime: fields[2] as DateTime,
      appointmentSubject: fields[3] as String,
      appointmentNote: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Appointment obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.appointmentMonth)
      ..writeByte(1)
      ..write(obj.appointmentDay)
      ..writeByte(2)
      ..write(obj.appointmentTime)
      ..writeByte(3)
      ..write(obj.appointmentSubject)
      ..writeByte(4)
      ..write(obj.appointmentNote);
  }

  @override
  int get typeId => 0;
}
