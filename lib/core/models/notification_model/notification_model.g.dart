// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  // TODO: implement typeId
  int get typeId => 6;
  @override
  NotificationModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      isSkipped: fields[5] as bool,
      isDone: fields[4] as bool,
      endTime: fields[3] as DateTime,
      reminderType: fields[0] as String,
      reminderId: fields[7] as String,
      dateTime: fields[2] as DateTime,
      id: fields[1] as String,
      recurrence: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.reminderType)
      ..writeByte(7)
      ..write(obj.reminderId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.isDone)
      ..writeByte(5)
      ..write(obj.isSkipped)
      ..writeByte(6)
      ..write(obj.recurrence);
  }
}
