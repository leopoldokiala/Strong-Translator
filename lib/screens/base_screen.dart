import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strong_translate/helpers/languages_helper.dart';
import 'package:strong_translate/models/page_manager.dart';
import 'package:strong_translate/screens/historic/historic_screen.dart';
import 'package:strong_translate/screens/traduction/traduction_screen.dart';
import 'package:strong_translate/services/i_services.dart';
import 'package:strong_translate/services/offline_translator_service.dart';
import 'package:strong_translate/services/translation_data_base_service.dart';
import 'package:strong_translate/widgets/my_app_bar.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => PageManager(_pageController),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => OfflineTranslatorService(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => LanguagesHelper(),
        ),
        ChangeNotifierProvider(lazy: false, create: (context) => IServices()),
        ChangeNotifierProvider<TranslationDataBase>(
          create: (_) => TranslationDataBase(),
          lazy: true,
        ),
      ],
      child: Consumer<PageManager>(
        builder: (context, pageManager, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xff2F4F4F),
            appBar: myAppBar(
              title: 'Strong Translator',
              color: Color(0xff008B8B),
            ),
            body: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                context.read<PageManager>().setPage(value);
              },
              children: [
                TraductionScreen(),
                HistoricScreen(),
                Center(
                  child: Text(
                    'Definição',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Color(0xff2F4F4F),
              unselectedIconTheme: Theme.of(context).iconTheme,
              selectedIconTheme: IconThemeData(),
              selectedItemColor: Theme.of(context).unselectedWidgetColor,
              unselectedItemColor: Theme.of(context).unselectedWidgetColor,
              selectedFontSize: 16,
              unselectedFontSize: 14,
              elevation: 0.0,
              currentIndex: pageManager.page,
              onTap: (value) {
                pageManager.setPage(value);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.translate_outlined),
                  label: 'Tradução',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history_rounded),
                  label: 'Histórico',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
