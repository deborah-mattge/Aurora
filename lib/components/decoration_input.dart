import 'package:flutter/material.dart';

InputDecoration getHabitInputDecorations({
  required String sendText,
  required double vertical,
  required double horizontal,
  required double width
}) {
  return InputDecoration(
    hintText: sendText,
    hintStyle: const TextStyle(fontSize: 15, color: Colors.black38),
    contentPadding: EdgeInsets.symmetric(
      vertical: vertical,
      horizontal: horizontal,
    ).add(EdgeInsets.only(right: width, left: width)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.black12,
        width: 1,
      ),
    ),
    filled: true, 
    fillColor: const Color.fromARGB(255, 252, 250, 250),
    
    // focusedBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(8),
    //   borderSide: const BorderSide(
    //     color: Colors.black26,
    //     width: 1,
    //   ),
    // ),
    // errorBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(8),
    //   borderSide: const BorderSide(
    //     color: Colors.red,
    //     width: 1,
    //   ),
    // ),
  );
}
