import 'package:flutter_hive_note/data/model/task_type_class.dart';
import 'package:hive/hive.dart';

part 'task_class.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String subtitle;

  @HiveField(2, defaultValue: false)
  bool isDone;

  @HiveField(3)
  DateTime time;

  @HiveField(4)
  TaskType taskType;

  Task({
    required this.title,
    required this.subtitle,
    this.isDone = false,
    required this.time,
    required this.taskType,
  });
}
