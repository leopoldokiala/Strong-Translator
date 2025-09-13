import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:text_to_speech/text_to_speech.dart';

class IServices extends ChangeNotifier {
  final TextToSpeech _tts = TextToSpeech();

  //Para copiar na área de transferência
  Future<void> copy(String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    notifyListeners();
  }

  //Converter texto em fala
  void speakText({required String text, required String languageCode}) {
    _tts.setLanguage(languageCode);
    _tts.speak(text);
    notifyListeners();
  }
}
