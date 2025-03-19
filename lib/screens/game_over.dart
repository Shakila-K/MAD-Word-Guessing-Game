import 'package:flutter/material.dart';
import 'package:word_guessing_game/screens/home.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Game Over!"),
            Text("Better luck next time."),
            ElevatedButton(onPressed: ()=> Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false), child: Text('Back'))
          ],
        ),
      ),
    );
  }
}