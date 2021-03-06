import 'package:readyuser/models/user.dart';
import 'package:readyuser/screens/home/account/profile_page.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:readyuser/screens/home/account/verify_phone.dart';
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  // text field state
  String email = userEmail;
  String password = '';
  String name = userName;
  String addr1 = userAddr1;
  String addr2 = userAddr2;
  String phoneNo = userPhoneNo;
  bool editProfile = false;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.data == null) return Loading();

          UserData userData = snapshot.data;
          return  !editProfile ? ProfilePage(
              user: userData,
              changeMode: (){
                setState(() {
                  editProfile = !editProfile;
                });
              }
          ) : Scaffold(
            backgroundColor: backgroundColor,
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    /*TextFormField(
                      initialValue: userEmail,
                      decoration: textInputDecoration.copyWith(hintText: 'E-Mail'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),

                     */
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userName,
                      decoration: textInputDecoration.copyWith(hintText: 'Name'),
                      validator: (val) {
                        if(val.length < 3)
                          return 'That is Not your name';
                        Pattern pattern =
                            r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]';
                        RegExp regex = new RegExp(pattern);
                        if (regex.hasMatch(val))
                          return 'That is not your name';
                        else
                          return null;
                      },
                      onChanged: (val) {
                       setState(() => name = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userAddr1,
                      decoration: textInputDecoration.copyWith(hintText: 'Address Line 1'),
                      validator: (val) => val.isEmpty ? 'Enter your Address' : null,
                      onChanged: (val) {
                        setState(() => addr1 = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userAddr2,
                      decoration: textInputDecoration.copyWith(hintText: 'Address Line 2'),
                      validator: (val) => val.isEmpty ? 'Enter your Address' : null,
                      onChanged: (val) {
                        setState(() => addr2 = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: buttonColor,
                        child: Text(
                          'Edit Data',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            print(email+" "+userUid+" "+name+" "+addr1+" "+addr2+" "+phoneNo);
                            UserData userData = new UserData(
                                email:email,
                                uid:userUid,
                                name: name,
                                addr1: addr1,
                                addr2: addr2,
                                phoneNo: phoneNo,
                                cartVal: userCartVal,
                                cartVendor: userCartVendor);
                            await DatabaseService(uid: userUid).updateUserData(userData).then((value) {
                              setState(() {
                                editProfile = !editProfile;
                              });
                            });
                            userEmail = email;
                            userName = name;
                            userAddr1 = addr1;
                            userAddr2 = addr2;
                            userPhoneNo = phoneNo;
                            final snackBar = SnackBar(
                              content: Text('Data Updated!'),
                            );

                            // Find the Scaffold in the widget tree and use
                            // it to show a SnackBar.
                            Scaffold.of(context).showSnackBar(snackBar);
                          }
                        }
                    ),
                    SizedBox(height: 12.0),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}