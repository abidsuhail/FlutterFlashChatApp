import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/mywidgets/mywidgets.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'register';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email,password;
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;

  void getCurrentUser()
  {
    final user =  _auth.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showProgress,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              kMainButton(color: Colors.blueAccent, text: 'Register', onPressed: () async{
                  //register email password
                setState(() {
                  showProgress = true;
                });
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password);
                  if(newUser!=null)
                    {
                      Navigator.pushNamed(context,ChatScreen.id);
                    }
                  setState(() {
                    showProgress = false;
                  });
                }
                catch(e)
                {
                  print(e);
                }

              }),
            ],
          ),
        ),
      ),
    );
  }
}
