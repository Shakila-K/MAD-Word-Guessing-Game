import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_guessing_game/screens/home.dart';
import 'package:word_guessing_game/services/api.dart';
import 'package:word_guessing_game/services/shared_prefs.dart';
import 'package:word_guessing_game/services/validators.dart';
import 'package:word_guessing_game/widgets/button.dart';

class GetUserName extends StatefulWidget {
  const GetUserName({super.key});

  @override
  State<GetUserName> createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {

  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Please enter your name", style: GoogleFonts.roboto(fontSize: 18),),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: TextFormField(
                    controller: nameController,
                    textAlign: TextAlign.center,
                    validator: (value) => Validators().validateString(value),
                  ),
                ),
                GeneralButton(
                  onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                      SharedPrefs().setStringValue('name', nameController.text);
                      await ApiService().addScore(nameController.text, 0);
                      if(context.mounted) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                      }
                    }
                  }, 
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Confirm')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}