import 'package:animalia/pages/home_page.dart';
import 'package:animalia/pages/login_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animalia/globals/globals.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Login check logic here.

  @override
  Widget build(BuildContext context) {
    user.setlogin(false);
    return AnimatedSplashScreen(
      centered: true,
      splash: Column(
        children: [
          Expanded(
              child: LottieBuilder.asset('assets/lottie/splash_screen.json')),
          const Text(
            "ANIMALIA",
            style: TextStyle(fontSize: 25, color: Color(0xFF989682)),
          )
        ],
      ),
      splashIconSize: 200,
      nextScreen:
          user.loggedIn ? const HomePage() : LoginPage(), // to be revised
      backgroundColor: const Color(0xFF3D341F),
    );
  }
}
