import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/screens/home/vendors/vendor_tile.dart';
import 'package:readyuser/shared/loading.dart';
import 'package:readyuser/shared/operations.dart';

class VendorList extends StatefulWidget {
  final Function selectVendor;
  VendorList({ this.selectVendor });

  @override
  _VendorListState createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  @override
  Widget build(BuildContext context) {

    final vendors = Provider.of<List<Vendor>>(context) ?? [];
    if(vendors == []) return Loading();
    //vendors.forEach((element) {print(element.name);});

    return FutureBuilder(
      future: Operate().sort(vendors),
      builder: (BuildContext context, AsyncSnapshot<List<Vendor>> snapshot) {
        if (snapshot.data == null) return Loading();
        List<Vendor> vendorsProcessed = snapshot.data;
        vendorsProcessed.forEach((element) {print(element.name);});
        print(vendorsProcessed.length);
        return ListView.builder(
          itemCount: vendorsProcessed.length,
          itemBuilder: (context, index) {
            //print(vendorsProcessed[index].name + vendorsProcessed[index].isAvailable.toString());
            //if(!vendorsProcessed[index].isAvailable) return null;
            return VendorTile(
              vendor: vendorsProcessed[index],
              selectVendor: widget.selectVendor,
            );
          },
        );
      },
    );
  }
}