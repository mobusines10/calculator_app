import 'package:flutter/material.dart';

class AppTheme {
  static const bg      = Color(0xFF080810);
  static const surface = Color(0xFF0F0F1A);
  static const card    = Color(0xFF14141F);
  static const border  = Color(0xFF222235);
  static const purple  = Color(0xFF6C5CE7);
  static const cyan    = Color(0xFF00CEC9);
  static const orange  = Color(0xFFFF5722);
  static const textPri = Color(0xFFF0F0F8);
  static const textSec = Color(0xFF7070A0);

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bg,
    primaryColor: purple,
    colorScheme: const ColorScheme.dark(primary: purple, secondary: cyan),
    useMaterial3: true,
  );

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: purple,
    useMaterial3: true,
  );
}