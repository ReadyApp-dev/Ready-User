import 'package:cloud_firestore/cloud_firestore.dart';

class Vendor {
  final String email;
  final String name;
  final String uid;
  final String addr1;
  final String addr2;
  final String phoneNo;
  final double latitude;
  final double longitude;
  final bool isAvailable;
  double distance;

  Vendor({ this.name, this.uid, this.addr1, this.addr2, this.phoneNo, this.email, this.latitude, this.longitude, this.isAvailable });

}