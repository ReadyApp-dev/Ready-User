import 'package:flutter/material.dart';
import 'package:readyuser/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readyuser/shared/constants.dart';

class Landing extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Future<void> _removeLoading() async {
      await Future.delayed(Duration(seconds: 10));
    }
    Future<bool> _onWillPop() async {
      //print("yes works");
      await _auth.signOut();
    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Ready'),
            backgroundColor: appBarColor,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Sign In'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ]
        ),
        body: Container(
          color: backgroundColor,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            children: <Widget>[
              Text("Verify your mail ID and login again"),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: buttonColor,
                child: Text(
                  "Resend Mail",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  firebaseUser = await FirebaseAuth.instance.currentUser();
                  firebaseUser.sendEmailVerification();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
