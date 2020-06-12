import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/screens/home/item_tile.dart';
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
    User user = Provider.of<User>(context);
    print(user);
    return StreamBuilder<List<Item>>(
        stream: DatabaseService(uid: user.uid).cart,
        builder: (context, snapshot) {
          List<Item> data = snapshot.data;
          myCart = data;
          if (data == null) return Loading();
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ItemTile(
                      item: data[index],
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
                onPressed: (){
                  print("yess");
                  Navigator.pop(context);
                  print("noo");
                },
              )
            ],
          );
        }
    );
  }
}
