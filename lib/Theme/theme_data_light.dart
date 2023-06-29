import 'package:flutter/material.dart';
import 'package:newsappus/Theme/AppColor.dart';
ThemeData getThemeDataLight() => ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color(0xFF1A237E),
    secondary: Color(0xFF616161),
    background: Colors.white,
    // Add more color properties as needed
  ),
  cardTheme: CardTheme(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);