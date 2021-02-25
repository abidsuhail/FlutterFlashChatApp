import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/mywidgets/mywidgets.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email,password;
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
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
              kMainButton(color: Colors.lightBlueAccent, text: 'Log In', onPressed: () async{
                //login clicked
                setState(() {
                  showProgress=true;
                });
                try {
                  UserCredential credential = await _auth
                      .signInWithEmailAndPassword(
                      email: email, password: password);
                  if(credential!=null)
                    {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  setState(() {
                    showProgress=false;
                  });
                }catch(e)
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
