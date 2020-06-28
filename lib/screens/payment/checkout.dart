import 'package:flutter/material.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/order.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/screens/home/cartAndMenu/item_tile.dart';
import 'package:readyuser/screens/payment/upi_pay.dart';
import 'package:readyuser/shared/loading.dart';
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
          userCartVal = double.parse((userCartVal).toStringAsFixed(2));

          return Scaffold(
            backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: appBarColor,
                elevation: 0.0,
                iconTheme: new IconThemeData(
                 color: Colors.black
                ),
                title: Text('Checkout Page',
                  style: new TextStyle(
                    color: Colors.black
                  ),
                )
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
                        color: appBarColor,
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
                          color: buttonColor,
                          child: Text(
                            "Pay Using UPI",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => PaymentPage()));
                          },
                        ),
                        RaisedButton(
                          color: buttonColor,
                          child: Text(
                            "Pay on Takeaway",
                            style: TextStyle(color: Colors.black),
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
                              paymentMethod: "Pay on Delivery",
                            );
                            print("order");
                            DatabaseService(uid: userUid).addOrderData(order);
                            DatabaseService(uid: userUid).addOrderDataVendor(order);
                            showDialog(
                              context:context,
                              barrierDismissible: false,
                            child:  WillPopScope(
                              onWillPop: (){},
                              child: new AlertDialog(
                                  title: new Text('Success!'),
                                  content: new Text('Order placed successfully Pick it in 30 minutes!'),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: Text("Have a nice day after you press me"),
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
