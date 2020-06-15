import 'package:flutter/material.dart';
import 'package:readyuser/models/order.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/shared/loading.dart';

class OrderTile extends StatefulWidget {
  final Order order;
  OrderTile({ this.order });

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: DatabaseService(uid: userUid).getVendorDetails(widget.order.vendor),
      builder: (context, snapshot) {
        //List<Item> out = [];
        //myMap.forEach((key, value) => out.add(new Item(id: key, cost: value['cost'], quantity: value['quantity'], name: value['name'])));
        //print(out);

        if(snapshot.data == null) return Loading();

        Vendor vendorData = snapshot.data;
        print(snapshot.data);
        print(vendorData.name);
        print(vendorData.addr1);
        print(vendorData.addr2);

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
              title: Text(vendorData.name),
              subtitle: Text(' ${widget.order.totalCost} '),
            ),
          ),
        );
      }
    );
  }
}