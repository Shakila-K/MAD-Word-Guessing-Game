import 'dart:async';

import 'package:flutter/material.dart';
import 'package:word_guessing_game/screens/get_name.dart';
import 'package:word_guessing_game/screens/home.dart';
import 'package:word_guessing_game/services/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(
      Duration(seconds: 1), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> checkUserName()? HomeScreen() : GetUserName()));
      }
    );
    super.initState();
  }

  bool checkUserName(){
    return SharedPrefs().getStringValue('name')== null ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("MAD Word Guessing Game"),
      ),
    );
  }
}