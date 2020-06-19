import 'package:flutter/cupertino.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/order.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/screens/home/orderHistory/ordered_item.dart';
import 'package:readyuser/screens/home/orderHistory/write_review.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetails extends StatelessWidget {

  Order order;
  Vendor vendor;
  OrderDetails({this.order, this.vendor});
  bool recieved = false;

  @override
  Widget build(BuildContext context) {
    List<Item> out = [];
    order.cart.forEach((key, value) => out.add(new Item(id: key, cost: value['cost'], quantity: value['quantity'], name: value['name'])));
    print(out);

    if (out == null) return Loading();
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.directions),
            label: Text('directions'),
            onPressed: () async {
              print(vendor.latitude);
              String lat = vendor.latitude.toString();
              print(vendor.longitude);
              String long = vendor.longitude.toString();
              String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${lat},${long}';
              if (await canLaunch(googleUrl)) {
                await launch(googleUrl);
              }
            },
          ),
        ],
      ),
      body: Container(
      color: Colors.brown[100],
        child: Column(
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
            Expanded(child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Total Order Value:\n ${userCartVal}",
                style: TextStyle(
                  color: Colors.pink[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            )),
            SizedBox(height:10.0),
            RaisedButton(
              color: Colors.pink[400],
              child: Text(
                "Press if You Got what you wanted",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: (){
                setState(){
                  recieved=true;
                }
              },
            ),
            SizedBox(height: 10),
            RaisedButton(
              color: Colors.pink[400],
              child: Text(
                "Write Review",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                print("yess");
                //Navigator.pop(context);
                Navigator.push(context, CupertinoPageRoute(builder: (context) => WriteReview(order: order)));
                //Navigator.pop(context);
                print("noo");
              },
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}