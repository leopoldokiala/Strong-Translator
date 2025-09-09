import 'package:flutter/material.dart';
import 'package:strong_translate/screens/base_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff2F4F4F),
        iconTheme: IconThemeData(color: Color(0xff008B8B)),
        unselectedWidgetColor: Color(0xfff9f7fe),
      ),
      debugShowCheckedModeBanner: false,
      home: BaseScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/traduction':
            return MaterialPageRoute(
              builder: (context) {
                return BaseScreen();
              },
            );
          case '/historical':
            return MaterialPageRoute(
              builder: (context) {
                return BaseScreen();
              },
            );
          case '/definition':
            return MaterialPageRoute(
              builder: (context) {
                return BaseScreen();
              },
            );
          default:
            MaterialPageRoute(
              builder: (context) {
                return BaseScreen();
              },
            );
        }
        return null;
      },
    );
  }
}
