import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class OfflineTranslatorService extends ChangeNotifier {
  OnDeviceTranslator? _translator;
  String _translatedText = '';
  bool _isTranslating = false;

  TranslateLanguage _sourceLang = TranslateLanguage.portuguese;
  TranslateLanguage _targetLang = TranslateLanguage.english;

  String get translatedText => _translatedText;
  bool get isTranslating => _isTranslating;

  TranslateLanguage get sourceLang => _sourceLang;
  TranslateLanguage get targetLang => _targetLang;

  /// Alterar idioma de origem
  void setSourceLang(TranslateLanguage lang) {
    _sourceLang = lang;
    notifyListeners();
  }

  /// Alterar idioma de destino
  void setTargetLang(TranslateLanguage lang) {
    _targetLang = lang;
    notifyListeners();
  }

  /// Inicializar tradutor (com base nos idiomas escolhidos)
  Future<void> initTranslator() async {
    _translator?.close();
    _translator = OnDeviceTranslator(
      sourceLanguage: _sourceLang,
      targetLanguage: _targetLang,
    );
  }

  /// Traduzir texto
  Future<void> translate(String text) async {
    if (_translator == null) return;

    _isTranslating = true;
    notifyListeners();

    try {
      final result = await _translator!.translateText(text);
      _translatedText = result;
    } catch (e) {
      _translatedText = 'Erro na tradução: $e';
    }

    _isTranslating = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _translator?.close();
    super.dispose();
  }
}
