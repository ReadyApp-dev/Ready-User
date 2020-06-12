import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/services/database.dart';
import 'package:flutter_counter/flutter_counter.dart';


class ItemTile extends StatefulWidget {
  final Item item;
  ItemTile({ this.item });

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {


  num _defaultValue = 0;
  num _counter = 0;


  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    _defaultValue = widget.item.quantity;
    _counter = widget.item.quantity;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[200],
              //backgroundImage: AssetImage('assets/coffee_icon.png'),
            ),
            title: Text(widget.item.name),
            subtitle: Text(' ${widget.item.id} '),
          /*
          onTap: () {
              print(widget.item);
              widget.item.quantity = 1;
              DatabaseService(uid: userUid).addItemToCart(widget.item);
              widget.selectItem();
            },

           */
            trailing: Counter(
              initialValue: _defaultValue,
              minValue: 0,
              maxValue: 10,
              step: 1,
              decimalPlaces: 0,
              onChanged: (value) {
                // get the latest value from here
                //currentVendor =
                if(myCart == null){
                  widget.item.quantity = 1;
                  myCart.add(widget.item);
                }
                int index = myCart.indexWhere((element) => element.id == widget.item.id);
                if(index == -1){
                  widget.item.quantity = 1;
                  myCart.add(widget.item);
                }else{
                  myCart[index].quantity = value;
                  widget.item.quantity = value;
                }
                DatabaseService(uid: userUid).addItemToCart(widget.item);
                setState(() {
                  _defaultValue = value;
                  _counter = value;

                });
              },
            ),
        ),
      ),
    );
  }
}