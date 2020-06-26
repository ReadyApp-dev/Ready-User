import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/screens/home/account/verify_phone.dart';

class ProfilePage extends StatelessWidget {

  final UserData user;
  final Function changeMode;

  ProfilePage({this.user, this.changeMode});


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: changeMode,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: Colors.teal[900],
                  ),
                  title: Text(
                    user.name,
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Neucha'),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.mail,
                    color: Colors.teal[900],
                  ),
                  title: Text(
                    user.addr1,
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Neucha'),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.mail,
                    color: Colors.teal[900],
                  ),
                  title: Text(
                    user.addr2,
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Neucha'),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.teal[900],
                  ),
                  title: Text(
                    user.phoneNo,
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Neucha'),
                  ),
                ),
              ),
              RaisedButton(
                color: buttonColor,
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0
                  ),
                ),
                onPressed: changeMode,
              ),
              !phoneVerified ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                    width: 200,
                    child: Divider(
                      color: Colors.teal[100],
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    "Verify phone to continue using app",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.teal[900],
                        ),
                        title: Text(
                          user.phoneNo,
                          style: TextStyle(
                              fontFamily: 'BalooBhai',
                              fontSize: 15.0
                          ),
                        ),
                      )
                  ),
                  RaisedButton(
                    color: buttonColor,
                    child: Text(
                      'Verify',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0
                      ),
                    ),
                    onPressed: () async {
                      if (true) {
                        Navigator.push(context, CupertinoPageRoute(
                            builder: (context) =>
                                VerifyPhone(phoneNo: userPhoneNo, otp: '')));
                      }
                    },
                  ),
                ],
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}