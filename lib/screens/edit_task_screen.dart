// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_hive_note/data/components/color_palette.dart';
import 'package:flutter_hive_note/data/components/textField_widget.dart';
import 'package:flutter_hive_note/data/model/task_class.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:time_pickerr/time_pickerr.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});

  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  void initState() {
    super.initState();

    titleFocusNode.addListener(() {
      setState(() {});
    });
    subtitleFocusNode.addListener(() {
      setState(() {});
    });

    titleController = TextEditingController(
      text: widget.task.title,
    );
    subtitleController = TextEditingController(
      text: widget.task.subtitle,
    );
    _time = widget.task.time;
  }

  TextEditingController? titleController;
  TextEditingController? subtitleController;
  final titleFocusNode = FocusNode();
  final subtitleFocusNode = FocusNode();
  final taskBox = Hive.box<Task>('taskBox');

  DateTime? _time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            inputTextFiled(
              label: 'عنوان تسک',
              color: titleFocusNode.hasFocus ? green : grey,
              maxLines: 1,
              controller: titleController,
              focusNode: titleFocusNode,
            ),
            SizedBox(
              height: 40,
            ),
            inputTextFiled(
              label: 'توضیحات',
              color: subtitleFocusNode.hasFocus ? green : grey,
              maxLines: 2,
              controller: subtitleController,
              focusNode: subtitleFocusNode,
            ),
            CustomHourPicker(
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
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                String taskTitle = titleController!.text;
                String taskSubtitle = subtitleController!.text;
                editTask(
                  taskTitle: taskTitle,
                  taskSubtitle: taskSubtitle,
                  time: _time!,
                );
                Navigator.of(context).pop();
              },
              child: Text(
                'ویرایش کردن تسک',
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
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  editTask({
    required String taskTitle,
    required String taskSubtitle,
    required DateTime time,
  }) {
    widget.task.title = taskTitle;
    widget.task.subtitle = taskSubtitle;
    widget.task.time = time;
    widget.task.save();
  }
}
