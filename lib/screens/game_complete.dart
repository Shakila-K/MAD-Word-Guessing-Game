import 'package:flutter/material.dart';
import 'package:word_guessing_game/screens/home.dart';
import 'package:word_guessing_game/services/api.dart';

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
            Text("You Won!"),
            Text("You correctly guessed the word."),
            ElevatedButton(onPressed: ()=> Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false), child: Text('Back'))
          ],
        ),
      ),
    );
  }
}