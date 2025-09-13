import 'package:flutter/material.dart';
import 'package:strong_translator/screens/base_screen.dart';
import 'package:strong_translator/screens/historic/historic_screen.dart';
import 'package:strong_translator/screens/traduction/traduction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strong Translator',
      theme: ThemeData(
        primaryColor: const Color(0xff2F4F4F),
        iconTheme: const IconThemeData(color: Color(0xff008B8B)),
        unselectedWidgetColor: const Color(0xfff9f7fe),
      ),
      debugShowCheckedModeBanner: false,
      home: BaseScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/traduction':
            return MaterialPageRoute(builder: (_) => TraductionScreen());
          case '/historical':
            return MaterialPageRoute(builder: (_) => HistoricScreen());
          default:
            return MaterialPageRoute(builder: (_) => BaseScreen());
        }
      },
    );
  }
}
