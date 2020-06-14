import 'package:flutter/material.dart';
class DrawerList extends StatelessWidget {
  final void Function(int) setValue;
  DrawerList(this.setValue);

  @override
  Widget build(BuildContext context) {
    List<Widget> lw = [
      DrawerHeader(
        child: Text('Custom Header'),
        decoration: BoxDecoration(
          color: Colors.blue,
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
