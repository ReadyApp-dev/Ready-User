import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/screens/home/vendor_list.dart';
import 'package:readyuser/screens/home/setting_form.dart';
import 'package:readyuser/services/auth.dart';
import 'package:readyuser/services/database.dart';

//import 'vendor_list.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }


    return StreamProvider<List<Vendor>>.value(
      value: DatabaseService().vendors,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
            color: Colors.brown[100],
            child: VendorList(
              selectVendor: (){
                setState(() {
                  print("yes it works");
                });
              },
            )
        ),
      ),
    );
  }
}