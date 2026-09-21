import 'package:flutter_hive_note/data/model/task_type_class.dart';
import 'package:flutter_hive_note/data/model/task_type_enum.dart';

List<TaskType> taskTypeList() {
  var list = [
    TaskType(
      image: 'assets/images/work.png',
      title: 'کار',
      taskTypeEnum: TaskTypeEnum.work,
    ),
    TaskType(
      image: 'assets/images/meet.png',
      title: 'قرار کاری',
      taskTypeEnum: TaskTypeEnum.meet,
    ),
    TaskType(
      image: 'assets/images/gym.png',
      title: 'باشگاه',
      taskTypeEnum: TaskTypeEnum.work,
    ),
    TaskType(
      image: 'assets/images/meditate.png',
      title: 'مدیتیشن',
      taskTypeEnum: TaskTypeEnum.work,
    ),
    TaskType(
      image: 'assets/images/pay.png',
      title: 'پرداخت قبض',
      taskTypeEnum: TaskTypeEnum.work,
    ),
    TaskType(
      image: 'assets/images/goOut.png',
      title: 'بیرون رفتن',
      taskTypeEnum: TaskTypeEnum.work,
    ),
    TaskType(
      image: 'assets/images/date.png',
      title: 'قرار دوستانه',
      taskTypeEnum: TaskTypeEnum.work,
    ),
  ];
  return list;
}
