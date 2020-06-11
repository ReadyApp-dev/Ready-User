import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/screens/authenticate/authenticate.dart';
import 'package:readyuser/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }

  }
}