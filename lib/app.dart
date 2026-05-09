import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/screen_01_splash.dart';
import 'screens/screen_02_home.dart';
import 'screens/screen_03_history.dart';
import 'screens/screen_04_scientific.dart';
import 'screens/screen_05_unit_converter.dart';
import 'screens/screen_06_settings.dart';
import 'screens/screen_07_about.dart';
import 'screens/screen_08_help.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: '/splash',
      routes: {
        '/splash':         (context) => const SplashScreen(),
        '/home':           (context) => const HomeScreen(),
        '/history':        (context) => const HistoryScreen(),
        '/scientific':     (context) => const ScientificScreen(),
        '/unit-converter': (context) => const UnitConverterScreen(),
        '/settings':       (context) => const SettingsScreen(),
        '/about':          (context) => const AboutScreen(),
        '/help':           (context) => const HelpScreen(),
      },
    );
  }
}