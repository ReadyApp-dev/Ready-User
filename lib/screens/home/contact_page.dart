import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

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
              SizedBox(height: 20,),
              Text("Covid 19 changed the way we live the way shop and the "
                  "entire world around us"
                  ".We are Ready to allow you to order "
                  "anything from anywhere.We'll be following up with  "
                  "Delivery soon.\nStay Always Ready. "
                  "\nStay Healthy. Stay Safe. \nKeep Ordering.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w200,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 15,),
              Card(
                margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child:InkWell(
                  onTap: () async{
                    await launch("mailto:ready.app.mnnit@gmail.com?subject=CustomerSupport");
                  }         ,
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                      'ready.app.mnnit@gmail.com',
                      style: new TextStyle(
                        color: Colors.black,
                      ),
                      ),
                    ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
