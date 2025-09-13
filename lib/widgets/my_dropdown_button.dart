import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

Widget myDropdownButton({
  Color? dropdownColor,
  BorderRadius? borderRadius,
  TranslateLanguage? value,
  List<DropdownMenuItem<TranslateLanguage>>? items,
  void Function(TranslateLanguage?)? onChanged,
}) {
  return DropdownButton<TranslateLanguage>(
    elevation: 0,
    dropdownColor: dropdownColor,
    borderRadius: borderRadius,
    style: TextStyle(color: Colors.white),
    value: value,
    items: items,
    onChanged: onChanged,
  );
}
