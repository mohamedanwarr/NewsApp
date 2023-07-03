import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappus/Theme/theme_data_light.dart';
import 'package:provider/provider.dart';

import 'Pages/SplashScreen.dart';
import 'Provider/ProviderApi.dart';
import 'Provider/ProviderTheme.dart';
import 'Theme/theme_data_dark.dart';

void main() {
  runApp( const NEWSAPP());
}

class NEWSAPP extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotfifier =
  ValueNotifier(ThemeMode.light);

  const NEWSAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(0, 255, 255, 255)));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<providertheme>(
          create: (context) => providertheme(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotfifier,
        builder: (_, ThemeMode curruntMode, $) {
          return MaterialApp(
            theme: getThemeDataLight(),
            darkTheme: getThemeDataDark(),
            themeMode: curruntMode,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
