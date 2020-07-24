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
      isClicked: fields[3] as bool,
      reminderType: fields[0] as String,
      dateTime: fields[2] as DateTime,
      id: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.reminderType)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.isClicked);
  }
}
