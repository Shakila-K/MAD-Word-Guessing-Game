import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:word_guessing_game/screens/splash_screen.dart';
import 'package:word_guessing_game/services/shared_prefs.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SharedPrefs().init().then((value) => runApp(const MyApp()));
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
