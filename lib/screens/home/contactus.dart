import 'package:flutter/material.dart';


class contactus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.brown[100],
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.email),
                  SizedBox(width: 3.0,),
                  Text('ready.app.mnnit@gmail.com'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
