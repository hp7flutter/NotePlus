import 'package:flutter/material.dart';
import 'package:flutter_hive_note/data/model/task_type_class.dart';
import 'package:flutter_hive_note/data/model/task_type_enum.dart';
import 'data/model/task_class.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_hive_note/screens/home_screen.dart';

void main() {
  start();
}

start() async {
  await initHive();
  Application application = Application();
  runApp(application);
}

initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  await Hive.openBox<Task>('taskBox');
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
