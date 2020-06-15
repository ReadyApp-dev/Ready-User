import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/screens/home/cartAndMenu/item_tile.dart';
import 'package:readyuser/screens/home/vendors/vendor_tile.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/shared/loading.dart';

class MenuList extends StatefulWidget {


  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context) ?? [];

    return StreamBuilder<List<Item>>(
      stream: DatabaseService(uid: userUid).cart,
      builder: (context, snapshot) {
        List<Item> data = snapshot.data;
        if(data == null) return Loading();
        print(data);
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            int ind = -1;
            if(data != null){
              ind = data.indexWhere((element) => element.id == items[index].id);
            }
            if(ind != -1)
              items[index].quantity = data[ind].quantity;
            print(items[index].quantity);

            return ItemTile(
              item: items[index],

            );
          },
        );
      }
    );
  }
}
