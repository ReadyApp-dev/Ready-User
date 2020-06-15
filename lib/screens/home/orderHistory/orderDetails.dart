import 'package:flutter/cupertino.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/order.dart';
import 'package:readyuser/screens/home/orderHistory/ordered_item.dart';
import 'package:readyuser/screens/home/orderHistory/write_review.dart';
import 'package:readyuser/shared/loading.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {

  Order order;
  OrderDetails({this.order});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  @override
  Widget build(BuildContext context) {
    List<Item> out = [];
    widget.order.cart.forEach((key, value) => out.add(new Item(id: key, cost: value['cost'], quantity: value['quantity'], name: value['name'])));
    print(out);

    if (out == null) return Loading();
        return Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: out.length,
                itemBuilder: (context, index) {
                  return OrderedItemTile(
                    item: out[index],
                  );
                },
              ),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              color: Colors.pink[400],
              child: Text(
                "Pay",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                print("yess");
                //Navigator.pop(context);
                Navigator.push(context, CupertinoPageRoute(builder: (context) => WriteReview()));
                //Navigator.pop(context);
                print("noo");
              },
            ),

          ],
        );
    }
}