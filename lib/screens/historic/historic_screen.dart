import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strong_translator/helpers/languages_helper.dart';

import 'package:strong_translator/services/translation_data_base_service.dart';
import '../../models/translation.dart';

class HistoricScreen extends StatelessWidget {
  const HistoricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<TranslationDataBase, LanguagesHelper>(
      builder: (context, dataBase, languageHelper, child) {
        return FutureBuilder<List<Translation>>(
          future: dataBase.getAllTranslations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xff008B8B)),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Erro ao carregar histórico',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Sem traduções no histórico',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final translations = snapshot.data!;
            return ListView.builder(
              itemCount: translations.length,
              itemBuilder: (context, index) {
                final translation = translations[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 85.0,
                        child: Card(
                          elevation: 1.9,
                          color: Theme.of(context).primaryColor,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                              top: 14.0,
                              left: 5.0,
                            ),
                            title: Text(
                              translation.sourceText,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                            ),
                            subtitle: Text(
                              translation.translatedText,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                await dataBase.deleteTranslation(
                                  translation.id!,
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 28.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 4.0, top: 4.0),
                          height: 30,
                          width: 190,
                          decoration: BoxDecoration(
                            color: Color(0xff008B8B),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(18.0),
                              topLeft: Radius.circular(8.0),
                            ),
                          ),

                          child: Container(
                            margin: EdgeInsets.only(left: 4.0, top: 2.0),
                            child: Text(
                              '${languageHelper.codeToName[translation.sourceLang] ?? translation.sourceLang}  -> ${languageHelper.codeToName[translation.targetLang] ?? translation.targetLang}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
