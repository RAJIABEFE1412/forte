import 'package:flutter/material.dart';

const kMainColor = Color(0xff083E9E);

const kBoxDecoration = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(6.0),
    topRight: Radius.circular(6.0),
    bottomRight: Radius.circular(6.0),
    bottomLeft: Radius.circular(1.5),
  ),
);

InputDecoration kInputDecoration =  InputDecoration(
  fillColor: Colors.grey.shade200,
  filled: true,
  border: InputBorder.none,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8.0)),
//    errorBorder: OutlineInputBorder(
//      borderSide: BorderSide(style: BorderStyle.solid,color: Colors.red),
//      borderRadius: BorderRadius.circular(8.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8.0)),
  hintStyle: TextStyle(
    color: Colors.grey.withOpacity(0.5),
  )
);