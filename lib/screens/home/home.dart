import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/screens/home/account/edit_account.dart';
import 'package:readyuser/screens/home/contact_page.dart';
import 'package:readyuser/screens/home/drawer_list.dart';
import 'package:readyuser/screens/home/cartAndMenu/menu_list.dart';
import 'package:readyuser/screens/home/orderHistory/order_list.dart';
import 'package:readyuser/screens/home/vendors/vendor_list.dart';
import 'package:readyuser/screens/home/cartAndMenu/cart_list.dart';
import 'package:readyuser/services/auth.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/shared/loading.dart';

class Home extends StatefulWidget {
  bool showVendors = true;
  num drawerItemSelected = 1;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String searchresult = '';
  bool search =false;

  _register() {
    _firebaseMessaging.getToken().then((token) {
      print(token+"end");
      userToken = token;
      DatabaseService(uid: userUid).updateTokenData(userToken);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();
  }

  void getMessage(){
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          //setState(() => _message = message["notification"]["title"]);
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      //setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      //setState(() => _message = message["notification"]["title"]);
    });
  }
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    userUid = user.uid;

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          color: Colors.black87,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
          child: CartWidget(),
        );
      },);
    }

    Future<bool> _onPopExit() async {
      if(widget.drawerItemSelected == 1 && widget.showVendors == false){
        setState(() {
          widget.showVendors = true;
        });
        return false;
      }else {(await showDialog(
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
              onPressed: () => SystemNavigator.pop(),
              child: new Text('Yes'),
            ),
          ],
        ),
      )) ?? false;
      }
    }

    Future<bool> _onPopHome() async {
      setState(() {
        widget.drawerItemSelected = 1;
        widget.showVendors = true;
      });
    }

    switch(widget.drawerItemSelected){
      case 1: {
        return new WillPopScope(
            onWillPop: _onPopExit,
            child:  Scaffold(
              drawer: Drawer(
                child: DrawerList((int i){
                  print(i);
                  setState(() {
                    widget.drawerItemSelected = i;
                    widget.showVendors = true;
                    Navigator.of(context).pop();
                  });
                }),
              ),
                backgroundColor: Colors.brown[50],
                appBar: widget.showVendors ?
                AppBar(
                  title: Text('Ready',
                    style: new TextStyle(
                      color: Colors.black,
                    ),),
                  iconTheme: new IconThemeData(color: Colors.black),
                  backgroundColor: appBarColor,
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
                ):
                AppBar(
                  title: search ? TextField(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    autofocus: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.black)),
                    onChanged: (val) {
                      setState(() {
                        searchresult = val;
                      });
                    },
                  )
                      :Text('Ready',
                    style: new TextStyle(
                      color: Colors.black,
                    ),),
                  iconTheme: new IconThemeData(color: Colors.black),
                  backgroundColor: appBarColor,
                  elevation: 0.0,
                  actions: <Widget>[
                    search ? IconButton(icon: Icon(Icons.close), onPressed: (){
                      setState(() {
                        search = !search;
                        searchresult = '';
                      });
                    }) :
                    FlatButton.icon(
                      icon: Icon(Icons.search),
                      label: Text('Search'),
                      onPressed: ()  {
                        setState(() {
                          search = !search;
                        });
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
                  color: backgroundColor,
                  child: widget.showVendors? StreamProvider<List<Vendor>>.value(
                    value: DatabaseService().vendors,
                    child:FutureBuilder<bool>(
                      future: DatabaseService(uid: userUid).getUserDetails(),
                      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        print("1");
                        if(snapshot.data == null) return Loading();
                        print(snapshot.data);
                        print("works here");
                        _register();
                        print('yes');
                        return FutureBuilder(
                          future: Geolocator().getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.best),
                          builder: (BuildContext context, AsyncSnapshot<Position> snapshot){
                            if(snapshot.data == null) return Loading();
                            Position pos = snapshot.data;
                            userLatitude = pos.latitude;
                            userLongitude = pos.longitude;
                            print(userLatitude+userLongitude);
                            currentVendor = '';
                            return VendorList(
                            selectVendor: (){
                              setState(() {
                                print("yes it works");
                                widget.showVendors = false;
                                searchresult='';
                                search=false;
                              });
                            },
                          );},
                        );
                      }
                    ),
                  ):StreamProvider<List<Item>>.value(
                    value: DatabaseService().items,
                    child:MenuList('$searchresult', search),
                  ),
                )
            )
        );
      }
      break;
      case 2: {
        return new WillPopScope(
            onWillPop: _onPopHome,
            child:  Scaffold(
                drawer: Drawer(
                  child: DrawerList((int i){
                    print(i);
                    setState(() {
                      widget.drawerItemSelected = i;
                      Navigator.of(context).pop();
                    });
                  }),
                ),
                backgroundColor: backgroundColor,
                appBar: AppBar(
                  title: Text('Ready',
                    style: new TextStyle(
                      color: Colors.black,
                    ),),
                  iconTheme: new IconThemeData(color: Colors.black),
                  backgroundColor: appBarColor,
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
                  color: backgroundColor,
                  child: SettingsForm(),
                )
            )
        );
      }
      break;
      case 3: {
        return new WillPopScope(
            onWillPop: _onPopHome,
            child:  Scaffold(
                drawer: Drawer(
                  child: DrawerList((int i){
                    print(i);
                    setState(() {
                      widget.drawerItemSelected = i;
                      Navigator.of(context).pop();
                    });
                  }),
                ),
                backgroundColor: backgroundColor,
                appBar: AppBar(
                  title: Text('Ready',
                    style: new TextStyle(
                      color: Colors.black,
                    ),),
                  iconTheme: new IconThemeData(color: Colors.black),
                  backgroundColor: appBarColor,
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
                  color: backgroundColor,
                  child: OrderWidget(),
                )
            )
        );
      }
      break;
      case 4: {
        return new WillPopScope(
            onWillPop: _onPopHome,
            child:  Scaffold(
                drawer: Drawer(
                  child: DrawerList((int i){
                    print(i);
                    setState(() {
                      widget.drawerItemSelected = i;
                      Navigator.of(context).pop();
                    });
                  }),
                ),
                backgroundColor: backgroundColor,
                appBar: AppBar(
                  title: Text('Ready',
                    style: new TextStyle(
                      color: Colors.black,
                    ),),
                  iconTheme: new IconThemeData(color: Colors.black),
                  backgroundColor: appBarColor,
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
                  color: backgroundColor,
                  child: ContactUs(),
                )
            )
        );
      }
      break;
    }
  }
}