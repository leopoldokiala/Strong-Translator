import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:provider/provider.dart';
import 'package:strong_translate/models/page_manager.dart';
import 'package:strong_translate/helpers/languages_helper.dart';
import 'package:strong_translate/models/translation.dart';
import 'package:strong_translate/screens/traduction/my_button.dart';
import 'package:strong_translate/services/i_services.dart';
import 'package:strong_translate/services/offline_translator_service.dart';
import 'package:strong_translate/services/translation_data_base_service.dart';

class TraductionScreen extends StatelessWidget {
  const TraductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<PageManager, OfflineTranslatorService, LanguagesHelper>(
      builder: (
        context,
        pageManager,
        translatorService,
        supportedLanguages,
        child,
      ) {
        return Column(
          children: [
            // Dropdown da língua de origem
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  DropdownButton<TranslateLanguage>(
                    elevation: 0,

                    dropdownColor: Theme.of(context).primaryColor,
                    alignment: Alignment.topLeft,
                    value: translatorService.sourceLang,
                    items:
                        supportedLanguages.supportedLanguages.entries.map((
                          entry,
                        ) {
                          return DropdownMenuItem(
                            value: entry.value,
                            child: Text(
                              entry.key,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        translatorService.setSourceLang(value);
                      }
                    },
                  ),
                ],
              ),
            ),

            // Campo de texto (ocupa metade do espaço)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 62.0, 16.0),
                    child: TextField(
                      controller: pageManager.controller,
                      style: TextStyle(
                        color: Theme.of(context).unselectedWidgetColor,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Digite aqui o teu texto',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        border: InputBorder.none,
                        focusColor: Color(0xff008B8B),
                      ),
                      maxLines: null,
                      expands: true,
                    ),
                  ),
                  if (pageManager.showButtons)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          myButton(
                            Icons.clear,
                            onTap: () {
                              pageManager.controller.clear();
                            },
                          ),
                          SizedBox(height: 6.0),
                          myButton(
                            Icons.copy_rounded,
                            onTap: () {
                              context.read<IServices>().copy(
                                pageManager.controller.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Texto copiado para área de transferência',
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 6.0),
                          myButton(Icons.mic_none_rounded, onTap: () {}),
                          SizedBox(height: 6.0),
                          myButton(Icons.volume_up_rounded, onTap: () {}),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Divider(color: Colors.black.withAlpha(40)),
                  if (pageManager.showButtons)
                    myButton(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        await translatorService.initTranslator();
                        await translatorService.translate(
                          pageManager.controller.text,
                        );
                        //Salvar a tradução no histórico
                        if (translatorService.translatedText.isNotEmpty) {
                          final translation = Translation(
                            sourceText: pageManager.controller.text,
                            translatedText: translatorService.translatedText,
                            sourceLang: translatorService.sourceLang.bcpCode,
                            targetLang: translatorService.targetLang.bcpCode,
                          );
                          await context
                              .read<TranslationDataBase>()
                              .saveTranslation(translation);
                        }
                      },
                      Icons.send_rounded,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  DropdownButton<TranslateLanguage>(
                    elevation: 0,
                    dropdownColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                    style: TextStyle(color: Colors.white),
                    value: translatorService.targetLang,
                    items:
                        supportedLanguages.supportedLanguages.entries.map((
                          entry,
                        ) {
                          return DropdownMenuItem(
                            value: entry.value,
                            child: Text(entry.key),
                          );
                        }).toList(),
                    onChanged: (value) async {
                      if (value != null) {
                        translatorService.setTargetLang(value);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child:
                      translatorService.isTranslating
                          ? Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                          : Text(
                            translatorService.translatedText.isEmpty
                                ? 'Tradução'
                                : translatorService.translatedText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
