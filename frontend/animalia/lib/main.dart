import 'package:animalia/pages/home_page.dart';
import 'package:animalia/pages/login_page.dart';
import 'package:animalia/pages/sign_up_page.dart';
import 'package:animalia/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Animalia',
        initialRoute: '/splashscreen',
        routes: {
          '/splashscreen': (context) => const SplashScreen(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/home': (context) => const HomePage(),
        },
        theme: ThemeData(
          fontFamily: 'Jungle Kid',
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
