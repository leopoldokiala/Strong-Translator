import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:strong_translate/services/translation_data_base_service.dart';
import '../../models/translation.dart';

class HistoricScreen extends StatelessWidget {
  const HistoricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TranslationDataBase>(
      builder: (context, dataBase, child) {
        return FutureBuilder<List<Translation>>(
          future: dataBase.getAllTranslations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar histórico'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Sem traduções no histórico'));
            }

            final translations = snapshot.data!;
            return ListView.builder(
              itemCount: translations.length,
              itemBuilder: (context, index) {
                final translation = translations[index];
                return Card(
                  elevation: 0.9,
                  color: Theme.of(context).primaryColor,
                  child: ListTile(
                    title: Text(
                      translation.sourceText,
                      style: TextStyle(
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
