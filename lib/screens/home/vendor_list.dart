import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/screens/home/vendor_tile.dart';

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

    return ListView.builder(
      itemCount: vendors.length,
      itemBuilder: (context, index) {
        return VendorTile(
          vendor: vendors[index],
          selectVendor: widget.selectVendor,
        );
      },
    );
  }
}