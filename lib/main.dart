import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsappus/Theme/theme_data_light.dart';
import 'package:newsappus/Theme_Data_Dark.dart';

import 'Pages/SplashScreen.dart';
import 'Theme/theme_data_dark.dart';

void main() {
  runApp( NEWSAPP());
}

class NEWSAPP extends StatelessWidget {
  static final ValueNotifier<ThemeMode>
  themeNotfifier = ValueNotifier(ThemeMode.light);

  NEWSAPP({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(0, 255, 255, 255)
    ));
   return ValueListenableBuilder<ThemeMode>(
      valueListenable:themeNotfifier,
      builder:(_,ThemeMode
      curruntMode,$){
        return    MaterialApp(
          theme:getThemeDataLight(),
          darkTheme:getThemeDataDark(),
          themeMode: curruntMode,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      }
    );

  }

}