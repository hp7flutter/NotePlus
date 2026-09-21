import 'package:hive_flutter/hive_flutter.dart';

part 'task_type_enum.g.dart';

@HiveType(typeId: 2)
enum TaskTypeEnum {

  @HiveField(0)
  work,

  @HiveField(1)
  meet,

  @HiveField(2)
  gym,

  @HiveField(3)
  meditate,

  @HiveField(4)
  payBills,

  @HiveField(5)
  hangingAround,

  @HiveField(6)
  date,
}
