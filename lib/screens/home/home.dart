import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/screens/home/item_list.dart';
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
  bool showVendors = true;
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


    Future<bool> _onWillPop() async {
      if(showVendors == false){
        setState(() {
          showVendors = true;
        });
        return false;
      }else{(await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: new Text('Yes'),
            ),
          ],
        ),
      )) ?? false;
      }
    }

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: showVendors ? StreamProvider<List<Vendor>>.value(
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
            child:VendorList(
              selectVendor: (){
                setState(() {
                  print("yes it works");
                  showVendors = false;
                });
              },
            ),
          ),
        ),
      ):




      StreamProvider<List<Item>>.value(
        value: DatabaseService().items,
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
            child:ItemList(
              selectItem: (){
                setState(() {
                  print("yes it works too");
                  showVendors = false;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

}