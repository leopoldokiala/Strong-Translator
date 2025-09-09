import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strong_translate/models/page_manager.dart';
import '../../services/offline_translator_service.dart';

class HistoricScreen extends StatelessWidget {
  const HistoricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<OfflineTranslatorService, PageManager>(
      builder: (context, translatorService, pageManager, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                pageManager.controller.text,
                style: TextStyle(
                  color: Theme.of(context).unselectedWidgetColor,
                ),
              ),
              subtitle: Text(
                'Ainda não traduzius',

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
  }
}
