// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  NotificationModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      isClicked: fields[4] as bool,
      reminderType: fields[0] as String,
      reminderId: fields[1] as String,
      dateTime: fields[3] as DateTime,
      id: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.reminderType)
      ..writeByte(1)
      ..write(obj.reminderId)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.isClicked);
  }

  @override
  // TODO: implement typeId
  int get typeId => 5;
}
