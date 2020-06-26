import 'package:flutter/material.dart';
import 'package:readyuser/services/auth.dart';
import 'package:readyuser/shared/check_box.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String addr1 = '';
  String addr2 = '';
  String phoneNo = '';
  bool _isSelected=false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
        title: Text(
          'Sign up to Ready',
          style: new TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'E-Mail'),
                validator: (val) {
                  if(val.isEmpty)
                    return 'Please Enter a valid Email';
                  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  if(!regex.hasMatch(val))
                    return 'Enter Valid Email';
                  else
                    return null;
                },
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
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
                decoration: textInputDecoration.copyWith(hintText: 'Address Line 1'),
                validator: (val) => val.isEmpty ? 'Enter your Address' : null,
                onChanged: (val) {
                  setState(() => addr1 = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Address Line 2'),
                validator: (val) => val.isEmpty ? 'Enter your Address' : null,
                onChanged: (val) {
                  setState(() => addr2 = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Phone Number'),
                validator: (val) {
                  if(val.length != 10)
                    return 'Enter a valid phone Number without country code';
                  Pattern pattern = r'(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(val))
                    return 'Enter valid Phone number without country code';
                  else
                    return null;
                },
                onChanged: (val) {
                  setState(() => phoneNo = val);
                },
              ),
              SizedBox(height: 20.0),
              LabeledCheckbox(
                label: 'This is the label text',
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                value: _isSelected,
                onChanged: (bool newValue) {
                  setState(() {
                    _isSelected = newValue;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              Builder(
                builder: (context) => RaisedButton(
                    color: buttonColor,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate() && _isSelected){
                        setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password, name, addr1, addr2, phoneNo);
                        if(result == null) {
                          setState(() {
                            loading = false;
                            error = 'Please supply a valid email';
                          });
                        }
                      }else if(!_isSelected){
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: appBarColor,
                          content: Text("Agree to Terms & Conditions to continue",
                          style: new TextStyle(
                            color: Colors.black,
                          ),),
                        ));
                      }
                    }
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}