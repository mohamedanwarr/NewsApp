import 'package:flutter/material.dart';

import '../main.dart';

class  providertheme extends ChangeNotifier{
changetheme() {
  NEWSAPP.themeNotfifier.value =
  NEWSAPP.themeNotfifier.value == ThemeMode.light
      ? ThemeMode.dark
      : ThemeMode.light;
  notifyListeners();
}

}
