import 'package:flutter_hive_note/data/model/task_type_enum.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task_type_class.g.dart';

@HiveType(typeId: 1)
class TaskType {

  @HiveField(0)
  String? image;

  @HiveField(1)
  String? title;

  @HiveField(2)
  TaskTypeEnum? taskTypeEnum;

  TaskType({
    this.image,
    this.title,
    this.taskTypeEnum,
  });
}
