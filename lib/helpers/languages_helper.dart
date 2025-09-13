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

  // Mapa inverso: código -> nome
  late final Map<String, String> codeToName = {
    for (var entry in supportedLanguages.entries)
      entry.value.bcpCode: entry.key,
  };

  // Mapa para o TextToSpeech
  final Map<String, String> ttsLanguageCodes = {
    "Português": "pt-PT", // ou "pt-BR" se preferir sotaque brasileiro
    "Inglês": "en-US",
    "Francês": "fr-FR",
    "Espanhol": "es-ES",
    "Alemão": "de-DE",
    "Italiano": "it-IT",
    "Chinesa": "zh-CN",
    "Japonesa": "ja-JP",
  };
}
