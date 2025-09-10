import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strong_translate/models/page_manager.dart';
import 'package:strong_translate/services/translation_data_base_service.dart';
import '../../models/translation.dart';
import '../../services/offline_translator_service.dart';

class HistoricScreen extends StatelessWidget {
  const HistoricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<
      OfflineTranslatorService,
      PageManager,
      TranslationDataBase
    >(
      builder: (context, translatorService, pageManager, dataBase, child) {
        return FutureBuilder<List<Translation>>(
          future: dataBase.getAllTranslations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar histórico'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Sem traduções no histórico'));
            }

            final translations = snapshot.data;
            return ListView.builder(
              itemCount: translations?.length,
              itemBuilder: (context, index) {
                final translation = translations?[index];
                return ListTile(
                  title: Text(
                    pageManager.controller.text,
                    style: TextStyle(
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                  subtitle: Text(
                    'Ainda não traduziu',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
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
