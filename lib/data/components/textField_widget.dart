import 'package:flutter/material.dart';
import 'package:flutter_hive_note/data/components/color_palette.dart';

Widget inputTextFiled({
  required String label,
  required Color color,
  required int maxLines,
  required TextEditingController? controller,
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
              width: 3,
              color: grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
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
