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
        leading: Icon(Icons.photo),
        title: Text('First layout'),
        onTap: (){setValue(3);},
      ),
      ListTile(
        title: Text('Communicate'),
        //without leading =),
      ),
      ListTile(
        leading: Icon(Icons.share),
        title: Text('Share layout'),
      )
    ];
    ListView lv = new ListView(children: lw,);
    return lv;
  }
}
