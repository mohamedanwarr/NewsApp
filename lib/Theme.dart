import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class ThemeClass {
  Color lightPrimaryColor = HexColor('#DF0054');
  Color darkPrimaryColor = HexColor('#480032');
  Color secondaryColor = HexColor('#FF8B6A');
  Color accentColor = HexColor('#FFD2BB');

  static ThemeData lightTheme = ThemeData(
    cardTheme: CardTheme(color: Colors.white),
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
        primary: _themeClass.lightPrimaryColor,
        secondary: _themeClass.secondaryColor),
  );

  static ThemeData darkTheme = ThemeData(
    cardTheme: CardTheme(color: Colors.white),
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _themeClass.darkPrimaryColor,
    ),
  );
}
ThemeClass _themeClass = ThemeClass();