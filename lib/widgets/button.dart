
import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final VoidCallback onPressed;

  const SmallButton(
      {super.key,
      required this.text,
      this.color,
      this.textColor,
      required this.onPressed
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Colors.black, 
          backgroundColor: color ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed, 
        child: Text(text)
        )
      );
  }
}

class GeneralButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? textColor;
  final VoidCallback onPressed;

  const GeneralButton(
      {super.key,
      required this.child,
      this.color,
      this.textColor,
      required this.onPressed
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Colors.black, 
          backgroundColor: color ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed, 
        child: child
        )
      );
  }
}

class BigButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? textColor;
  final VoidCallback onPressed;

  const BigButton(
      {super.key,
      required this.child,
      this.color,
      this.textColor,
      required this.onPressed
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Colors.black, 
          backgroundColor: color ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed, 
        child: child
        )
      );
  }
}