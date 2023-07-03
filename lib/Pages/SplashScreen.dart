import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'HomePage.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(
        splash: Lottie.asset('assets/newslogo.json'),
        duration: 4000,
        splashIconSize: 250,
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.fadeTransition,
         nextScreen: const HomePage());
  }
}
