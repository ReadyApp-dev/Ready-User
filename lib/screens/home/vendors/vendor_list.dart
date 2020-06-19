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
    return FutureBuilder(
      future: Operate().sort(vendors),
      builder: (BuildContext context, AsyncSnapshot<List<Vendor>> snapshot) {
        if (snapshot.data == null) return Loading();
        List<Vendor> vendorsProcessed = snapshot.data;
        return ListView.builder(
          itemCount: vendorsProcessed.length,
          itemBuilder: (context, index) {
            print(vendorsProcessed[index].distance);
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