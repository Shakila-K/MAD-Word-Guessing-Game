import 'package:flutter/material.dart';
import 'package:word_guessing_game/widgets/button.dart';

class HintButton extends StatelessWidget {
  final String text;
  final int marks;
  final VoidCallback onPressed;
  const HintButton({
    super.key,
    required this.text,
    required this.marks,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text),
          )),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SmallButton(
              onPressed:  onPressed, 
              text: '-$marks pts', 
              color: Colors.red[700],
              textColor: Colors.white,
            ),
          ))
      ],
    );
  }
}
