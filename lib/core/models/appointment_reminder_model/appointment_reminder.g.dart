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
      id: fields[0] as String,
      reminderDates: (fields[8] as List)?.cast<DateTime>(),
      alertType: fields[7] as String,
      time: (fields[4] as List)?.cast<int>(),
      isDone: fields[5] as bool,
      isSkipped: fields[6] as bool,
      appointmentType: fields[1] as String,
      note: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Appointment obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.appointmentType)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.isDone)
      ..writeByte(6)
      ..write(obj.isSkipped)
      ..writeByte(7)
      ..write(obj.alertType)
      ..writeByte(8)
      ..write(obj.reminderDates);
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;
}
