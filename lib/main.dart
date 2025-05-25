import 'package:flutter/material.dart';

// all pages
import 'screens/loading_page.dart';
import 'screens/start_page.dart';
import 'screens/more_page.dart';
import 'screens/map_page.dart';
import 'screens/info_page.dart';
import 'screens/account_page.dart';

void main() {
  runApp(const RegioKArgoTramTrainApp());
}

class RegioKArgoTramTrainApp extends StatelessWidget {
  const RegioKArgoTramTrainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RegioKArgoTramTrain',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // loading page
      initialRoute: '/loading',

      routes: {
        // routes
        '/loading': (context) => LoadingPage(),
        '/start': (context) => StartPage(),
        '/more': (context) => MorePage(),
        '/map': (context) => MapPage(),
        '/info': (context) => InfoPage(),
        '/account': (context) => AccountPage(),
      },
    );
  }
}
