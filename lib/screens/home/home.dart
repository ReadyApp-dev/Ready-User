import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/screens/home/drawer_list.dart';
import 'package:readyuser/screens/home/item_list.dart';
import 'package:readyuser/screens/home/vendor_list.dart';
import 'package:readyuser/screens/home/cart_list.dart';
import 'package:readyuser/services/auth.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';

class Home extends StatefulWidget {
  bool showVendors = true;
  num drawerItemSelected = 1;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    userUid = user.uid;
    DatabaseService(uid: userUid).userDetails();

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
          child: CartWidget(),
        );
      },);
    }

    Future<bool> _onWillPop() async {
      if(widget.showVendors == false){
        setState(() {
          widget.showVendors = true;
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
    switch(widget.drawerItemSelected){
      case 1: {
        return new WillPopScope(
            onWillPop: _onWillPop,
            child:  Scaffold(
              drawer: Drawer(
                child: DrawerList((int i){
                  print(i);
                }),
              ),
                backgroundColor: Colors.brown[50],
                appBar: AppBar(
                  title: Text('Ready'),
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
                      icon: Icon(Icons.shopping_cart),
                      label: Text('cart'),
                      onPressed: () => _showSettingsPanel(),
                    )
                  ],
                ),
                body: Container(
                  color: Colors.brown[100],
                  child: widget.showVendors? StreamProvider<List<Vendor>>.value(
                    value: DatabaseService().vendors,
                    child:VendorList(
                      selectVendor: (){
                        setState(() {
                          print("yes it works");
                          widget.showVendors = false;
                        });
                      },
                    ),
                  ):StreamProvider<List<Item>>.value(
                    value: DatabaseService().items,
                    child:ItemList(),
                  ),
                )
            )
        );
      }

    }


  }
}