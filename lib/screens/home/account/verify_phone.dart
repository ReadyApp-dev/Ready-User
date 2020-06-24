import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyPhone extends StatefulWidget {
  String phoneNo;
  String otp;
  VerifyPhone({this.phoneNo,this.otp});
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final _formKey = GlobalKey<FormState>();
  bool showButton = false;
  String verifyId;



  Future<dynamic> showError(BuildContext context,Exception error) {
    SharedPreferences
        .getInstance().then((value) => value.setBool('phoneVerified', false));
    phoneVerified = false;
    return showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text('Verification failed!'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: new Text('OK'),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {


    Future<void> _removeLoading() async {
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        Navigator.pop(context);
      });
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
        title: Text('Verify Phone'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: widget.phoneNo,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Phone Number'),
                validator: (val) {
                  if (val.length != 10)
                    return 'Enter a valid phone Number without country code';
                  Pattern pattern = r'(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(val))
                    return 'Enter valid Phone number without country code';
                  else
                    return null;
                },
                onChanged: (val) {
                  setState(() => widget.phoneNo = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: buttonColor,
                  child: Text(
                    'Send Otp',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      print("sent");
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: "+91" + widget.phoneNo,
                        timeout: Duration(seconds: 60),
                        verificationCompleted: (
                            AuthCredential phoneAuthCredential) async {
                          await firebaseUser.linkWithCredential(
                              phoneAuthCredential).then((value) async{
                            firebaseUser = value.user;

                            userPhoneNo = widget.phoneNo;
                            UserData newUserData = new UserData(
                              email:userEmail,
                              uid:userUid,
                              name: userName,
                              addr1: userAddr1,
                              addr2: userAddr2,
                              phoneNo: userPhoneNo,
                            );
                            print(newUserData.phoneNo);
                            await DatabaseService(uid: userUid).updateUserData(newUserData);
                            SharedPreferences prefs = await SharedPreferences
                                .getInstance();
                            prefs.setBool('phoneVerified', true);
                            phoneVerified = true;
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return new AlertDialog(
                                    title: new Text('Verification Successful!'),
                                    actions: <Widget>[
                                      new FlatButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: new Text('OK'),
                                      ),
                                    ],
                                  );
                                }
                            );
                          }).catchError((e){
                            showError(context, e);
                          });
                        },
                        verificationFailed: (AuthException error) async {
                          showError(context, error);
                        },
                        codeSent: (String verificationId,
                            [int forceResendingToken]) {
                          verifyId = verificationId;
                          setState(() {
                            showButton = true;
                          });
                        },
                        codeAutoRetrievalTimeout: null,
                      );
                    }
                  }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'OTP'),
                onChanged: (val) {
                  setState(() => widget.otp = val);
                },
              ),
              SizedBox(height: 20.0),
              showButton? RaisedButton(
                  color: buttonColor,
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      AuthCredential _phoneAuthCredential = PhoneAuthProvider
                          .getCredential(
                          verificationId: verifyId, smsCode: widget.otp);
                      print("yes");
                      print(_phoneAuthCredential);
                      firebaseUser = await FirebaseAuth.instance.currentUser();
                      print(firebaseUser.uid);
                      firebaseUser.linkWithCredential(_phoneAuthCredential)
                          .then((value) async{
                        firebaseUser = value.user;

                        userPhoneNo = widget.phoneNo;
                        UserData newUserData = new UserData(
                          email:userEmail,
                          uid:userUid,
                          name: userName,
                          addr1: userAddr1,
                          addr2: userAddr2,
                          phoneNo: userPhoneNo,
                        );
                        print(newUserData.phoneNo);
                        await DatabaseService(uid: userUid).updateUserData(newUserData);
                        SharedPreferences prefs = await SharedPreferences
                            .getInstance();
                        prefs.setBool('phoneVerified', true);
                        phoneVerified = true;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return new AlertDialog(
                                title: new Text('Verification Successful!'),
                                actions: <Widget>[
                                  new FlatButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: new Text('OK'),
                                  ),
                                ],
                              );
                            }
                        );
                      }).catchError((e){
                        showError(context, e);
                      });
                    }
                  }
              ):Container(),
              SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }
}