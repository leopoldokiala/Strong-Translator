import 'package:flutter/material.dart';

Widget myButton({IconData? icon, required Function() onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Color(0xff008B8B),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Icon(icon, color: Colors.white),
    ),
  );
}
