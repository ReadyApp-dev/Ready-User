import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/order.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/services/database.dart';
import 'package:flutter_counter/flutter_counter.dart';

class OrderTile extends StatefulWidget {
  final Order order;
  OrderTile({ this.order });

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {

  @override
  Widget build(BuildContext context) {
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
          title: Text(widget.order.vendor),
          subtitle: Text(' ${widget.order.id} '),
        ),
      ),
    );
  }
}