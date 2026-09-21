// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_hive_note/screens/edit_task_screen.dart';
import 'package:iconsax/iconsax.dart';

import 'color_palette.dart';
import '../model/task_class.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({
    super.key,
    required this.task,
  });
  Task task;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  String replaceFarsiNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }
    return input;
  }

  bool isBoxChecked = false;

  @override
  void initState() {
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return _task_card(
      taskTitle: widget.task.title,
      taskSubtitle: widget.task.subtitle,
    );
  }

  Widget _task_card({
    required String taskTitle,
    required String taskSubtitle,
  }) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(1, 4),
            blurStyle: BlurStyle.normal,
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _chekbox(),
                    SizedBox(width: 8),
                    Visibility(
                      visible: isBoxChecked,
                      child: _remove_task(),
                    ),
                    Spacer(),
                    _title_subtitle(
                      taskTitle: taskTitle,
                      taskSubtitle: taskSubtitle,
                    ),
                  ],
                ),
                _badgeButtons(),
              ],
            ),
          ),
          Image.asset('assets/images/work_meeting.png'),
        ],
      ),
    );
  }

  Widget _chekbox() {
    return InkWell(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isBoxChecked ? Colors.indigo : grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.check,
          color: isBoxChecked ? white : Colors.grey,
        ),
      ),
    );
  }

  Widget _remove_task() {
    return InkWell(
      onTap: () {
        setState(() {
          widget.task.delete();
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.clear,
          color: white,
        ),
      ),
    );
  }

  Widget _title_subtitle({
    required String taskTitle,
    required String taskSubtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          widget.task.title,
          style: TextStyle(
            fontFamily: 'Shabnam',
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        Text(
          widget.task.subtitle,
          style: TextStyle(
            fontFamily: 'Shabnam',
            fontSize: 14,
            color: Colors.grey[600],
          ),
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }

  addZeroHour(DateTime time) {
    if (time.hour < 10)
      return replaceFarsiNumber('0${time.hour}');
    else
      time.hour.toString();
  }

  addZeroMinute(DateTime time) {
    if (time.minute < 10)
      return replaceFarsiNumber('0${time.minute}');
    else
      time.minute.toString();
  }

  Widget _badgeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 112,
          height: 40,
          decoration: BoxDecoration(
            color: isBoxChecked ? grey : green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                // '${addZeroHour(widget.task.time)}:${addZeroMinute(widget.task.time)}',
                '${widget.task.time.hour}:${widget.task.time.minute}',
                style: TextStyle(
                  fontFamily: 'Shabnam',
                  fontSize: isBoxChecked ? 16 : 20,
                  color: white,
                ),
              ),
              Icon(
                isBoxChecked ? Icons.check : Iconsax.clock,
                color: white,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(
                  task: widget.task,
                ),
              ),
            );
          },
          child: Container(
            width: 112,
            height: 40,
            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'ویرایش',
                  style: TextStyle(
                    fontFamily: 'Shabnam',
                    fontSize: 16,
                    color: green,
                  ),
                ),
                Icon(
                  Iconsax.edit,
                  color: green,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
