import 'package:flutter/material.dart';
import 'package:readyuser/models/item.dart';

String currentVendor = "";
String userUid = "";
String userName = '';
String userEmail = '';
String userAddr1 = '';
String userAddr2 = '';
String userPhoneNo = '';
String userCartVendor = '';
double userCartVal = 0.0;

List<Item> myCart = [];

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);