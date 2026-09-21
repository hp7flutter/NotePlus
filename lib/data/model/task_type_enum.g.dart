// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTypeEnumAdapter extends TypeAdapter<TaskTypeEnum> {
  @override
  final int typeId = 2;

  @override
  TaskTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskTypeEnum.work;
      case 1:
        return TaskTypeEnum.meet;
      case 2:
        return TaskTypeEnum.gym;
      case 3:
        return TaskTypeEnum.meditate;
      case 4:
        return TaskTypeEnum.payBills;
      case 5:
        return TaskTypeEnum.hangingAround;
      case 6:
        return TaskTypeEnum.date;
      default:
        return TaskTypeEnum.work;
    }
  }

  @override
  void write(BinaryWriter writer, TaskTypeEnum obj) {
    switch (obj) {
      case TaskTypeEnum.work:
        writer.writeByte(0);
        break;
      case TaskTypeEnum.meet:
        writer.writeByte(1);
        break;
      case TaskTypeEnum.gym:
        writer.writeByte(2);
        break;
      case TaskTypeEnum.meditate:
        writer.writeByte(3);
        break;
      case TaskTypeEnum.payBills:
        writer.writeByte(4);
        break;
      case TaskTypeEnum.hangingAround:
        writer.writeByte(5);
        break;
      case TaskTypeEnum.date:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
