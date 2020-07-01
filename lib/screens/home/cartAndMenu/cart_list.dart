import 'package:flutter/cupertino.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/screens/home/cartAndMenu/item_tile.dart';
import 'package:readyuser/screens/payment/checkout.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  @override
  Widget build(BuildContext context) {
    double sum = 0.0;
    User user = Provider.of<User>(context);
    print(user);
    return StreamBuilder<List<Item>>(
        stream: DatabaseService(uid: user.uid).cart,
        builder: (context, snapshot) {
          List<Item> data = snapshot.data;

          if (data == null) return Loading();
          myCart = new List.from(data);
          print(myCart);
          sum = 0.0;
          myCart.forEach((element) {sum += element.cost*element.quantity;});
          userCartVal = sum;
          print(sum);
          userCartVal = double.parse((userCartVal).toStringAsFixed(2));

          return Column(
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
                        item: data[index],
                        removeItem:(){
                          setState((){
                            data.removeAt(index);
                          });
                        },
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
                        "Total Cart Value:\n ₹${userCartVal}",
                        style: TextStyle(
                            color: appBarColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                    ),
                  )),
                  Expanded(
                    child: RaisedButton(
                      color: buttonColor,
                      child: Text(
                        "Pay and Checkout",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        if(!myCart.isEmpty)
                        {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>checkoutpage()));
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        }
    );
  }
}
