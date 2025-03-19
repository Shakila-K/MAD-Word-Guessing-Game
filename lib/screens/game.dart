import 'dart:async';
import 'package:flutter/material.dart';
import 'package:word_guessing_game/screens/game_complete.dart';
import 'package:word_guessing_game/screens/game_over.dart';
import 'package:word_guessing_game/services/api.dart';
import 'package:word_guessing_game/services/validators.dart';
import 'package:word_guessing_game/widgets/hint_button.dart';
import 'package:word_guessing_game/widgets/show_snackbar.dart';

class GameScreen extends StatefulWidget {
  final String name;
  final int userScore;
  const GameScreen({super.key, required this.name,required this.userScore});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  TextEditingController wordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late int currentScore;
  late Timer _timer;
  int secondsElapsed = 0;
  String? secretWord;
  late int attempts;

  bool letterCountHint = false;
  bool btnLoading = false;

  List<String> hints = [];

  @override
  void initState() {
    super.initState();
    currentScore = 100;
    startTimer();
    fetchSecretWord(); // Fetch the word once
    attempts = 0;
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        secondsElapsed++;
      });
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  void fetchSecretWord() async {
    secretWord = (await ApiService().getRandomWord())?.toLowerCase();
    setState(() {}); // Update UI after fetching the word
  }

  void guessWord() async {
    if (secretWord == null) return;
    if(_formKey.currentState!.validate()){
      setState(() {
        attempts+=1;
      });
      if (wordController.text.toLowerCase() == secretWord) {
        stopTimer(); // Stop the timer on correct guess
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GameComplete(totalMarks: widget.userScore+currentScore, name: widget.name,)));
      } else {
        setState(() {
          currentScore -= 10;
        });
        if(currentScore<=0 || attempts ==0){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> GameOverScreen()));
        }
        if (attempts == 5) {
          setState(() {
            btnLoading = true;
          });
        final similarWords = await ApiService().getSimilarWord(secretWord!);
        final rhymingWords = await ApiService().getRhymingWord(secretWord!);
        if (similarWords != null && rhymingWords !=null) {
          if(!mounted) return;
          showSnackBar(context, '5 incorrect guesses. You have recieved a hint!', Colors.blue);
          setState(() {
            hints.add('Similar words to the secret word: \n${similarWords.join(', ')}');
            hints.add('Rhyming words to the secret word: \n${rhymingWords.join(', ')}\n');
            btnLoading = false;
          });
        }
      }
        if(!mounted) return;
        showSnackBar(context, 'Incorrect Guess', Colors.red);
      }
    } 
  }

  Future<void> checkLetterOccurrenceDialog() async {
    final formKey = GlobalKey<FormState>(); 
    TextEditingController letterController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check a letter'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please enter the letter you want to check.'),
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: letterController,
                    validator: (value) => Validators().validateCharacter(value),
                  )
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Check (-5 pts)'),
              onPressed: () {
                if(formKey.currentState!.validate()){
                  String letter = letterController.text.toLowerCase();
                  int letterCount = secretWord!.split(letter).length - 1; // Count occurrences of the letter
                  setState(() {
                    hints.add('Letter "$letter" appears $letterCount times in this word.');
                    currentScore -= 5;
                  });
                  showSnackBar(context, 'You have received a hint! 5 points have been deducted', Colors.blue);
                  Navigator.of(context).pop();
                }
                
              },
            ),
          ],
        );
      },
    );
  }

  void showLetterCountHint() {
    if (secretWord == null || letterCountHint) {
      showSnackBar(context, 'You have already used this hint', Colors.red);
      return;
    }
    setState(() {
      hints.add('The word has ${secretWord!.length} letters.');
      currentScore -= 5;
      letterCountHint = true;
    });
    showSnackBar(context, 'You have received a hint! 5 points have been deducted', Colors.blue);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess the Word'),
        centerTitle: true,
      ),
      body: secretWord == null
          ? Center(child: CircularProgressIndicator()) // Show loader until word is fetched
          : Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Score: $currentScore",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("Time: ${secondsElapsed}s",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: wordController,
                        decoration:
                            InputDecoration(hintText: "Enter your guess here"),
                        validator: (value) =>
                            Validators().validateString(value),
                      ),
                    ),
                  ),
                  Text('Attempts : $attempts'),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: !btnLoading? guessWord : null,
                      child: !btnLoading ? Text("Guess") : CircularProgressIndicator(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      showModalBottomSheet(
                        context: context,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                                  child: Column(
                                    children: [
                                      HintButton(
                                        text: 'Occurrence of a letter',
                                        marks: 5,
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                          checkLetterOccurrenceDialog();
                                        },
                                      ),
                                      HintButton(
                                        text: 'Letters in the word',
                                        marks: 5,
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                          showLetterCountHint();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text("Hint!"),
                  ),
                  Container(
                    margin: EdgeInsets.all(40),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                    ),
                    height: 300,
                    child: ListView.builder(
                      itemCount: hints.length,
                      itemBuilder: (BuildContext context, int index){
                        return Text(hints[index]);
                      }
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
