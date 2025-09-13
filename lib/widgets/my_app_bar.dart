import 'package:flutter/material.dart';

PreferredSize myAppBar({String? title, Color? color}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(kToolbarHeight),
    child: SafeArea(
      child: Container(
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
        ),
        child: Center(
          child: Text(
            title ?? '',
            style: TextStyle(color: Colors.white, fontSize: 22.0),
          ),
        ),
      ),
    ),
  );
}
