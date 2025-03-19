import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_guessing_game/screens/home.dart';
import 'package:word_guessing_game/widgets/button.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Game Over!", style: GoogleFonts.barriecito(fontSize: 50, color: Colors.red, fontWeight: FontWeight.w700),),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text("Better luck next time.", style: GoogleFonts.roboto(color: Colors.black, fontSize: 18),),
            ),
            GeneralButton(onPressed: ()=> Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false), child: Text('Back'))
          ],
        ),
      ),
    );
  }
}