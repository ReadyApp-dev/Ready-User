import 'package:flutter/material.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/shared/constants.dart';

class VendorTile extends StatelessWidget {

  final Vendor vendor;
  final Function selectVendor;
  VendorTile({ this.vendor, this.selectVendor });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[vendor.strength],
            //backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(vendor.name),
          subtitle: Text(' ${vendor.addr1} ${vendor.addr2} '),
          onTap: () {
            currentVendor = vendor.id;
            print(currentVendor);
            selectVendor();
          }),
        ),
      );
    }
  }