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
                color: backgroundColor,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              child: Text('$userName',
                style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,
                  color: backgroundColor,
                    fontSize: 25,
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: appBarColor,
        ),
      ),
      ListTile(
        leading: Icon(Icons.home,color: Colors.white,),
        title: Text('Home',style: new TextStyle(color: Colors.white),),
        onTap: (){setValue(1);},
      ),
      ListTile(
        leading: Icon(Icons.account_box,color: Colors.white,),
        title: Text('Profile',style: new TextStyle(color: Colors.white),),
        onTap: (){setValue(2);},
      ),
      ListTile(
        leading: Icon(Icons.history,color: Colors.white,),
        title: Text('Order History',style: new TextStyle(color: Colors.white),),
        onTap: (){setValue(3);},
      ),
      ListTile(
        title: Text('Communicate',style: new TextStyle(color: Colors.white),),
        //without leading =),
      ),
      ListTile(
        leading: Icon(Icons.perm_contact_calendar,color: Colors.white,),
        title: Text('Contact Us',style: new TextStyle(color: Colors.white),),
        onTap: (){setValue(4);},
      )
    ];
    Widget lv =new Container(
        color: backgroundColor,
        child:ListView(
          children: lw,
        )
    );
    return lv;
  }
}