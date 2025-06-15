import 'package:flutter/material.dart';

// all pages
import 'screens/loading_page.dart';
import 'screens/start_page.dart';
import 'screens/more/more_page.dart';
import 'screens/map/map_page.dart';
import 'screens/information/info_page.dart';
import 'screens/account/account_page.dart';
import 'screens/orders/deliver/qr_scan_introduction_page.dart';
import 'screens/orders/deliver/qr_code_display_page.dart';
import 'screens/orders/deliver/qr_scan_success_page.dart';
//import 'screens/orders/deliver/qr_scan_failed_page.dart';
import 'screens/orders/deliver/repetition_process_page.dart';
import 'screens/orders/deliver/pickup_done.dart';

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
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF009940)),
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
        '/qr_scan_introduction': (context) => QrScanInstructionPage(),
        '/qr_code_display': (context) => QrCodeDisplayPage(),
        '/qr_scan_success': (context) => QrScanSuccessPage(),
        //'/qr_scan_failed': (context) => QrScanFailed(),
        '/repetition_process': (context) => RepetitionProcessPage(),
        '/pickup_done': (context) => PickupDone()
      },
    );
  }
}
