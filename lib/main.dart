import 'package:flutter/material.dart';
import 'package:word_guessing_game/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD Word Guessing Game',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
