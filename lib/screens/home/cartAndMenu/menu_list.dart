import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/screens/home/cartAndMenu/item_tile.dart';
import 'package:readyuser/screens/home/vendors/vendor_tile.dart';

class MenuList extends StatefulWidget {


  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context) ?? [];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ItemTile(
          item: items[index],

        );
      },
    );
  }
}
