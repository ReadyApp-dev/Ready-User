import 'package:flutter/material.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/order.dart';
import 'package:readyuser/screens/home/home.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:upi_india/upi_india.dart';
import 'package:flutter/cupertino.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/screens/home/cartAndMenu/item_tile.dart';
import 'package:readyuser/screens/payment/upi_pay.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class checkoutpage extends StatefulWidget {
  @override
  _checkoutpageState createState() => _checkoutpageState();
}

class _checkoutpageState extends State<checkoutpage> {
  @override
  Widget build(BuildContext context) {
    double suma = 0.0;
    User user = Provider.of<User>(context);
    print(user);
    return StreamBuilder<List<Item>>(
        stream: DatabaseService(uid: user.uid).cart,
        builder: (context, snapshot) {
          List<Item> data = snapshot.data;

          if (data == null) return Loading();
          myCart = new List.from(data);
          print(myCart);
          suma = 0.0;
          myCart.forEach((element) {suma += element.cost*element.quantity;});
          userCartVal = suma;
          print(suma);

          return Scaffold(
            backgroundColor: Colors.brown[100],
              appBar: AppBar(
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
                title: Text('Checkout Page')
              ),
            body:Column(
            children: <Widget>[
              Expanded(
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ItemTile(
                            item: data[index]
                          );
                        },
                      );}
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Total Cart Value:\n ${userCartVal}",
                      style: TextStyle(
                        color: Colors.pink[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            "Pay",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            print("yess");
                            Navigator.pop(context);
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => PaymentPage()));
                            //Navigator.pop(context);
                            print("noo");
                          },
                        ),
                        RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            "Pay on Delivery",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            Map<String, dynamic> myMap = new Map();
                            myMap = Map.fromIterable(myCart, key: (e) => e.id, value: (e) => {'cost':e.cost,'quantity':e.quantity, 'name':e.name});
                            print(myMap);
                            List<Item> out = [];
                            myMap.forEach((key, value) => out.add(new Item(id: key, cost: value['cost'], quantity: value['quantity'], name: value['name'])));
                            print(out);
                            print('Transaction Successful');
                            Order order = new Order(
                              status: "Order Placed",
                              cart:  myMap?? '',
                              totalCost: userCartVal ?? '0.0',
                              user: userUid ?? '0',
                              vendor: userCartVendor ?? '0',
                            );
                            print("order");
                            DatabaseService(uid: userUid).addOrderData(order);
                            DatabaseService(uid: userUid).addOrderDataVendor(order);
          showDialog(
            context:context,
                            child:  new AlertDialog(
                                title: new Text('Success!'),
                                content: new Text('Order placed successfully'),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: Text("Payed"),
                                    onPressed: () async{
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      await DatabaseService(uid: userUid).clearCart();
                                      print('works');
                                      userCartVal = 0.0;
                                      userCartVendor = '';
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          );
        }
    );
  }
}
