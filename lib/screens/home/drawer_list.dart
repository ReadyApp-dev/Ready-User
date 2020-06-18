import 'package:flutter/cupertino.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:flutter/material.dart';
class DrawerList extends StatelessWidget {
  final void Function(int) setValue;
  DrawerList(this.setValue);

  @override
  String name=userName;
  Widget build(BuildContext context) {
    List<Widget> lw = [
      DrawerHeader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                'Welcome',
                style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,
                color: Colors.brown[800],
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              child: Text('$name',
                style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,
                  color: Colors.brown[800],
                    fontSize: 25,
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.brown[200],
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: (){setValue(1);},
      ),
      ListTile(
        leading: Icon(Icons.account_box),
        title: Text('Profile'),
        onTap: (){setValue(2);},
      ),
      ListTile(
        leading: Icon(Icons.history),
        title: Text('Order History'),
        onTap: (){setValue(3);},
      ),
      ListTile(
        title: Text('Communicate'),
        //without leading =),
      ),
      ListTile(
        leading: Icon(Icons.perm_contact_calendar),
        title: Text('Contact Us'),
      )
    ];
    ListView lv = new ListView(children: lw,);
    return lv;
  }
}