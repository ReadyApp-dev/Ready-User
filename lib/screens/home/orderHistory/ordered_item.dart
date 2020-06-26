import 'package:flutter/material.dart';
import 'package:readyuser/models/item.dart';

class OrderedItemTile extends StatelessWidget {
  Item item;
  OrderedItemTile({this.item});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.grey,
            //backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(item.name),
          subtitle: Text(' ₹${item.cost} '),
          trailing: Text(' ${item.quantity}'),
        ),
      ),
    );
  }
}

