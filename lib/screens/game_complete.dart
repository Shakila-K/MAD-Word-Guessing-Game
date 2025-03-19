import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_guessing_game/screens/home.dart';
import 'package:word_guessing_game/services/api.dart';
import 'package:word_guessing_game/widgets/button.dart';

class GameComplete extends StatefulWidget {
  final String name;
  final int totalMarks;
  const GameComplete({super.key, required this.totalMarks, required this.name});

  @override
  State<GameComplete> createState() => _GameCompleteState();
}

class _GameCompleteState extends State<GameComplete> {

  void updateScore() async{
    print('${widget.name}, ${widget.totalMarks}');
    ApiService().addScore(widget.name, widget.totalMarks);
  }

  @override
  void initState() {
    updateScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You Won!", style: GoogleFonts.barriecito(fontSize: 60, color: Colors.green, fontWeight: FontWeight.w700),),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text("You correctly guessed the word.",  style: GoogleFonts.roboto(color: Colors.black, fontSize: 18),),
            ),
            GeneralButton(onPressed: ()=> Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false), child: Text('Back'))
          ],
        ),
      ),
    );
  }
}