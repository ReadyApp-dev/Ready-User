import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/screens/wrapper.dart';
import 'package:readyuser/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
