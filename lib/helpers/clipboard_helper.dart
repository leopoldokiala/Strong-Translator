import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ClipboardHelper extends ChangeNotifier {
  Future<void> copy(String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    notifyListeners();
  }

  Future<String> paste() async {
    final clipboard = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboard?.text ?? '';
  }

  Future<bool> hasData() async {
    return Clipboard.hasStrings();
  }
}
