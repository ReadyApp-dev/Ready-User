import 'package:readyuser/models/user.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String addr1 = '';
  String addr2 = '';
  String phoneNo = '';

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.data == null) return Loading();

          email = userEmail;
          name = userName;
          addr1 = userAddr1;
          addr2 = userAddr2;
          phoneNo = userPhoneNo;


          UserData userData = snapshot.data;
          return  Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Edit Account'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userEmail,
                      decoration: textInputDecoration.copyWith(hintText: 'E-Mail'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userName,
                      decoration: textInputDecoration.copyWith(hintText: 'Name'),
                      validator: (val) => val.isEmpty ? 'Enter your' : null,
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
                    TextFormField(
                      initialValue: userPhoneNo,
                      decoration: textInputDecoration.copyWith(hintText: 'Phone Number'),
                      validator: (val) => val.length < 10 ? 'Enter a valid phone Number' : null,
                      onChanged: (val) {
                        setState(() => phoneNo = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            UserData newUserData = new UserData(email:email,uid:userUid,name: name, addr1: addr1, addr2: addr2, phoneNo: phoneNo,cartVal: userCartVal,cartVendor: userCartVendor);
                            await DatabaseService(uid: userUid).updateUserData(newUserData);
                            final snackBar = SnackBar(
                              content: Text('Yay! A SnackBar!'),
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