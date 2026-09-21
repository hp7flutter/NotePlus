// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_hive_note/data/components/color_palette.dart';
import 'package:flutter_hive_note/data/model/task_class.dart';
import 'package:flutter_hive_note/data/model/task_type_class.dart';
import 'package:flutter_hive_note/data/model/task_utility.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:time_pickerr/time_pickerr.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  void initState() {
    super.initState();
    titleFocusNode.addListener(() {
      setState(() {});
    });
    subtitleFocusNode.addListener(() {
      setState(() {});
    });
  }

  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final titleFocusNode = FocusNode();
  final subtitleFocusNode = FocusNode();
  final taskBox = Hive.box<Task>('taskBox');
  DateTime? _time;
  //  = DateTime.now();
  int _selectedTaskTypeItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            inputTextFiled(
              label: 'عنوان تسک',
              color: titleFocusNode.hasFocus ? green : grey,
              maxLines: 1,
              controller: titleController,
              focusNode: titleFocusNode,
            ),
            SizedBox(height: 16),
            inputTextFiled(
              label: 'توضیحات',
              color: subtitleFocusNode.hasFocus ? green : grey,
              maxLines: 2,
              controller: subtitleController,
              focusNode: subtitleFocusNode,
            ),
            time_picker(),
            taskTypeItem(),
            Spacer(),
            saveTaskButton(context),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget taskTypeItem() {
    return Container(
      height: 128,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: taskTypeList().length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTaskTypeItem = index;
              });
            },
            child: TaskTypeItemList(
              taskType: taskTypeList()[index],
              index: index,
              selectedItemList: _selectedTaskTypeItem,
            ),
          );
        },
      ),
    );
  }

  Widget time_picker() {
    return CustomHourPicker(
      elevation: 0.5,
      date: DateTime.now(),
      title: 'انتخاب زمان',
      titleStyle: TextStyle(
        fontFamily: 'shabnam',
        fontSize: 18,
        color: Colors.grey[800],
      ),
      positiveButtonText: 'انتخاب',
      positiveButtonStyle: TextStyle(
        fontFamily: 'shabnam',
        fontSize: 16,
        color: Colors.green,
      ),
      onPositivePressed: (context, time) {
        _time = time;
      },
      negativeButtonText: 'انصراف',
      negativeButtonStyle: TextStyle(
        fontFamily: 'shabnam',
        fontSize: 16,
        color: Colors.red,
      ),
      onNegativePressed: (context) {},
    );
  }

  Widget saveTaskButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        String taskTitle = titleController.text;
        String taskSubtitle = subtitleController.text;
        addTask(
          taskTitle: taskTitle,
          taskSubtitle: taskSubtitle,
          time: _time!,
        );
        Navigator.of(context).pop();
      },
      child: Text(
        'اضافه کردن تسک',
        style: TextStyle(
          fontFamily: 'Shabnam',
          fontSize: 20,
          color: white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 12,
        ),
        backgroundColor: green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget inputTextFiled({
    required String label,
    required Color color,
    required int maxLines,
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 0,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          cursorColor: Colors.grey,
          maxLines: maxLines,
          style: TextStyle(
            fontFamily: 'Shabnam',
            fontSize: 20,
            color: Colors.grey,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 2,
                color: grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: green,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            label: Text(
              ' $label ',
              style: TextStyle(
                fontFamily: 'Shabnam',
                fontSize: 20,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  addTask({
    required String taskTitle,
    required String taskSubtitle,
    required DateTime time,
  }) {
    Task task = Task(
      title: taskTitle,
      subtitle: taskSubtitle,
      time: time,
      taskType: taskTypeList()[_selectedTaskTypeItem],
    );
    taskBox.add(task);
  }
}

class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList({
    required this.taskType,
    required this.index,
    required this.selectedItemList,
    super.key,
  });
  TaskType taskType;
  int index;
  int selectedItemList;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color:
              (selectedItemList == index) ? Colors.green : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Image.asset(taskType.image!),
          Text(
            taskType.title!,
            style: TextStyle(
              fontFamily: 'shabnam',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
