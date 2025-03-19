import 'package:flutter/material.dart';
import 'package:word_guessing_game/screens/home.dart';
import 'package:word_guessing_game/services/api.dart';
import 'package:word_guessing_game/services/shared_prefs.dart';
import 'package:word_guessing_game/services/validators.dart';

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
                Text("Please enter your name"),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: TextFormField(
                    controller: nameController,
                    textAlign: TextAlign.center,
                    validator: (value) => Validators().validateString(value),
                  ),
                ),
                ElevatedButton(
                  onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                      SharedPrefs().setStringValue('name', nameController.text);
                      await ApiService().addScore(nameController.text, 0);
                      if(context.mounted) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                      }
                    }
                  }, 
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