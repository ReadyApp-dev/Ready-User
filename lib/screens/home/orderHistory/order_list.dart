import 'package:flutter/cupertino.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/order.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/screens/home/cartAndMenu/item_tile.dart';
import 'package:readyuser/screens/home/orderHistory/order_item.dart';
import 'package:readyuser/screens/payment/upi_pay.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';
import 'package:readyuser/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatefulWidget {
  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {

  @override
  Widget build(BuildContext context) {
    double sum = 0.0;
    User user = Provider.of<User>(context);
    print(user);
    return StreamBuilder<List<Order>>(
        stream: DatabaseService(uid: user.uid).orderHistory,
        builder: (context, snapshot) {
          List<Order> data = snapshot.data;


          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return OrderTile(
                      order: data[index],
                    );
                  },
                ),
              ),
              SizedBox(height: 10.0),

            ],
          );
        }
    );
  }
}
