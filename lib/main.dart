import 'package:flutter/material.dart';

// Import all pages/screens
import 'screens/loading_page.dart';
import 'screens/start_page.dart';
import 'screens/more/more_page.dart';
import 'screens/map/map_page.dart';
import 'screens/information/info_page.dart';
import 'screens/account/account_page.dart';
import 'screens/orders/deliver/qr_scan_introduction_page.dart';
import 'screens/orders/deliver/qr_code_display_page.dart';
import 'screens/orders/deliver/qr_scan_success_page.dart';
import 'screens/orders/deliver/qr_scan_failed_page.dart';
import 'screens/orders/deliver/repetition_process_page.dart';
import 'screens/orders/deliver/pickup_done.dart';

/// Application entry point.
void main() {
  runApp(const RegioKArgoTramTrainApp());
}

/// Root widget of the RegioKargo TramTrain application.
///
/// This widget configures the MaterialApp with all necessary routes,
/// theming, and initial settings for the entire application.
class RegioKArgoTramTrainApp extends StatelessWidget {
  const RegioKArgoTramTrainApp({super.key});

  /// Build the application widget tree.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RegioKArgoTramTrain',
      theme: ThemeData(
        useMaterial3: false,
        // Define the app's color scheme with green accent color (#009940)
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF009940)),
      ),
      // Start with the loading page as the initial route
      initialRoute: '/loading',

      // Define all application routes
      routes: {
        '/loading': (context) => const LoadingPage(),
        '/start': (context) => const StartPage(),
        '/more': (context) => const MorePage(),
        '/map': (context) => const MapPage(),
        '/info': (context) => const InfoPage(),
        '/account': (context) => const AccountPage(),
        '/qr_scan_introduction': (context) => const QrScanInstructionPage(),
        '/qr_code_display': (context) => const QrCodeDisplayPage(),
        '/qr_scan_success': (context) => const QrScanSuccessPage(),
        '/qr_scan_failed': (context) => const QrScanFailed(),
        '/repetition_process': (context) => const RepetitionProcessPage(),
        '/pickup_done': (context) => const PickupDone(),
      },
    );
  }
}
