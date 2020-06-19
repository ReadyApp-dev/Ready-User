import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:readyuser/models/item.dart';
import 'package:readyuser/models/order.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/models/user.dart';
import 'package:readyuser/shared/constants.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference vendorCollection = Firestore.instance.collection('vendors');


  Future<void> addItemToCart(Item item) async {
    print(item);
    print(uid);
    return await userCollection.document(uid).collection('cart').document(item.id).setData({
      'name': item.name,
      'cost': item.cost,
      'quantity': item.quantity,
    });
  }

  // brew list from snapshot
  List<Vendor> _vendorListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){

      print(doc.documentID);
      return Vendor(
        name: doc.data['name'] ?? '',
        uid: doc.documentID,
        phoneNo: doc.data['phone'] ?? '0',
        addr1: doc.data['address1'] ?? '0',
        addr2: doc.data['address2'] ?? '0',
        latitude: doc.data['location'].latitude  ?? 0.0,
        longitude: doc.data['location'].longitude  ?? 0.0,
        isAvailable: doc.data['isAvailable'] ?? true,
      );
    }).toList();
  }

  Future<void> getUserDetails() async{
    return await userCollection.document(uid).get().then((value) {

      userUid = uid;
      userName = value.data['name'];
      userEmail = value.data['email'];
      userAddr1 = value.data['address1'];
      userAddr2 = value.data['address2'];
      userPhoneNo = value.data['phone'];
      userCartVendor = value.data['cartVendor'];
      userCartVal = value.data['cartVal'];

    });
  }
  
  Future<Vendor> getVendorDetails(String vendorId) async{
    return await vendorCollection.document(vendorId).get().then((value) {
      return Vendor(
        uid: vendorId,
        email: value.data['email'],
        name: value.data['name'],
        addr1: value.data['address1'],
        addr2: value.data['address2'],
        phoneNo: value.data['phone'],
        latitude: value.data['location'].latitude  ?? 0.0,
        longitude: value.data['location'].longitude  ?? 0.0,
        isAvailable: value.data['isAvailable'] ?? true,
      );
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      email: snapshot.data['email'],
      name: snapshot.data['name'],
      addr1: snapshot.data['address1'],
      addr2: snapshot.data['address2'],
      phoneNo: snapshot.data['phone'],
      cartVendor: snapshot.data['cartVendor'],
      cartVal: snapshot.data['cartVal'],
    );
  }

  Future<void> updateUserData(UserData userData) async {
    return await userCollection.document(uid).setData({
      'name': userData.name,
      'email': userData.email,
      'address1': userData.addr1,
      'address2': userData.addr2,
      'phone': userData.phoneNo,
      'cartVendor': userData.cartVendor,
      'cartVal': userData.cartVal,
    });
  }
  // brew list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.documentID);
      return Item(
        name: doc.data['name'] ?? '',
        id: doc.documentID,
        cost: doc.data['cost'] ?? 0.0,
        quantity: doc.data['quantity'] ?? 0,
      );
    }).toList();
  }

  Future<void> addOrderData(Order order) async {
    return await userCollection.document(uid).collection("orderHistory").add({
      'cart': order.cart,
      'status': order.status,
      'totalCost': order.totalCost,
      'user': order.user,
      'vendor': order.vendor,
    });
  }
  Future<void> addOrderDataVendor(Order order) async {
    return await vendorCollection.document(order.vendor).collection("orderHistory").add({
      'cart': order.cart,
      'status': order.status,
      'totalCost': order.totalCost,
      'user': order.user,
      'vendor': order.vendor,
    });
  }

  Future<void> updateOrderData(Order order) async {
    return await userCollection.document(uid).collection("orderHistory").document(order.id).setData({
      'cart': order.cart,
      'status': order.status,
      'totalCost': order.totalCost,
      'user': order.user,
      'vendor': order.vendor,
    });
  }

  Future<void> updateOrderDataVendor(Order order) async {
    return await vendorCollection.document(order.vendor).collection("orderHistory").document(order.id).setData({
      'cart': order.cart,
      'status': order.status,
      'totalCost': order.totalCost,
      'user': order.user,
      'vendor': order.vendor,
    });
  }

  Future<void> updateReview(Order order,double star, String review) async {
    return await vendorCollection.document(order.vendor).collection("reviews").document(order.id).setData({
      'star': star,
      'review': review,
    });
  }

  // brew list from snapshot
  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.documentID);
      return Order(
        id: doc.documentID,
        cart: doc.data['cart'] ?? '',
        status: doc.data['status'],
        totalCost: doc.data['totalCost'] ?? '0.0',
        user: doc.data['user'] ?? '0',
        vendor: doc.data['vendor'] ?? '0',
      );
    }).toList();
  }

  Future<void> clearCart() async{
    await userCollection.document(uid).collection('cart').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
  }
  

  // delete all documents in a collection
  Future<void> _deleteAll(QuerySnapshot snapshot) async {
    for (DocumentSnapshot doc in snapshot.documents) {
      doc.reference.delete();
    }
  }

  // get vendors stream
  Stream<List<Vendor>> get vendors {
    //print(vendorCollection.getDocuments());
    return vendorCollection.snapshots()
        .map(_vendorListFromSnapshot);
  }

  // get menu items stream
  Stream<List<Item>> get items {
    //print(vendorCollection.getDocuments());
    return vendorCollection.document(currentVendor).collection('menu').snapshots()
        .map(_itemListFromSnapshot);
  }

  // get get cart item stream
  Stream<List<Item>> get cart {
    //print(vendorCollection.getDocuments());
    return userCollection.document(uid).collection('cart').snapshots()
        .map(_itemListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  Stream<List<Order>> get orderHistory {
    return userCollection.document(uid).collection('orderHistory').snapshots()
        .map(_orderListFromSnapshot);
  }

  
}