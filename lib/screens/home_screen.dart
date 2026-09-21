import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hive_note/data/components/color_palette.dart';
import 'package:flutter_hive_note/data/components/task_widget.dart';
import 'package:flutter_hive_note/data/model/task_class.dart';
import 'package:flutter_hive_note/screens/add_task_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box<Task>('taskBox');
  bool isFABvisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: taskBox.listenable(),
          builder: (context, value, child) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                setState(() {
                  if (notification.direction == ScrollDirection.forward) {
                    isFABvisible = true;
                  }
                  if (notification.direction == ScrollDirection.reverse) {
                    isFABvisible = false;
                  }
                });
                return true;
              },
              child: ListView.builder(
                itemCount: taskBox.values.length,
                itemBuilder: ((context, index) {
                  var task = taskBox.values.toList()[index];
                  return _listItems(task);
                }),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: isFABvisible,
        child: FloatingActionButton(
          backgroundColor: white,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            size: 40,
            color: green,
          ),
        ),
      ),
    );
  }

  Widget _listItems(Task task) => Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) => task.delete(),
        child: TaskWidget(
          task: task,
        ),
      );
}
