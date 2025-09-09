import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class LanguagesHelper extends ChangeNotifier {
  final Map<String, TranslateLanguage> supportedLanguages = {
    "Português": TranslateLanguage.portuguese,
    "Inglês": TranslateLanguage.english,
    "Francês": TranslateLanguage.french,
    "Espanhol": TranslateLanguage.spanish,
    "Alemão": TranslateLanguage.german,
    "Italiano": TranslateLanguage.italian,
    "Chinesa": TranslateLanguage.chinese,
    "Japonesa": TranslateLanguage.japanese,
  };
}
