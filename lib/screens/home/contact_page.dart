import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
              Text("During Covid maintaining social distancing is as important "
                  "as shopping essentials. We are Ready to allow you to order "
                  "anything from anywhere. Know which shop has what you want, "
                  "Order before leaving home and avail cashless service for "
                  "you own security.We'll be following up with  "
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
              ),
              SizedBox(height: 40),
              Center(
                child: RichText(
                  text:new TextSpan(
                    text: '(View Terms & Conditions)',
                    style: new TextStyle(color: Colors.blue),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () { launch('https://drive.google.com/file/d/1pMnwkTk02F0B-gOeDROMWxq4ZTpms_cp/view?usp=sharing');
                      },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
