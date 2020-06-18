import 'package:flutter/material.dart';
import 'package:readyuser/services/auth.dart';

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
            backgroundColor: Colors.brown[400],
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
          color: Colors.brown[100],
          child: Text("Verify your mail ID and login again"),
        ),
      ),
    );
  }
}
