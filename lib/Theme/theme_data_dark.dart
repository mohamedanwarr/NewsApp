import 'package:flutter/material.dart';

ThemeData getThemeDataDark() => ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFF1A237E),
    secondary: const Color(0xFF616161),
    background: Colors.grey.shade900,
    // Add more color properties as needed
  ),
  cardTheme: CardTheme(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
