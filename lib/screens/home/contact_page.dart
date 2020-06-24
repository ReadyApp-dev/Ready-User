import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readyuser/shared/constants.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("During Covid maintaining social distancing is as important as shopping essentials.",
                style: TextStyle(color: Colors.white,letterSpacing: 1,fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 4,),
                Text("We are Ready to allow you to order anything from anywhere.",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 4,),
                Text("Know which shop has what you want, Order before leaving home and avail cashless service for you own security.",
                  style: TextStyle(color: Colors.white,letterSpacing: 1,fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 4,),
                Text("We'll be following up with  Delivery soon. Keep in touch. ",
                  style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold,letterSpacing: 1,fontSize: 20),),
                SizedBox(height: 4,),
                Text("Stay Always Ready. ",style: TextStyle(color: Colors.white,letterSpacing: 1,fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 4,),
                Text(  "Stay Healthy. ",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 1,fontSize: 20)),
                SizedBox(height: 4,),
                Text( "Stay Safe. Take care.",
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 1,fontSize: 20),
              ),
              SizedBox(height: 15,),
              Card(
                margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.email),
                    SizedBox(width: 13.0,),
                    Text('ready.app.mnnit@gmail.com',
                      style: new TextStyle(
                        color: Colors.black,fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
