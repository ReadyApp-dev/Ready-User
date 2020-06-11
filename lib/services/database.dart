import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('users');
  final CollectionReference vendorCollection = Firestore.instance.collection('vendors');

  Future<void> updateUserData(String email, String name, String addr1, String addr2, String phoneNo) async {
    return await brewCollection.document(uid).setData({
      'name': name,
      'email': email,
      'address1': addr1,
      'address2': addr2,
      'phone': phoneNo,
    });
  }

  // brew list from snapshot
  List<Vendor> _vendorListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.documentID);
      return Vendor(
        name: doc.data['Name'] ?? '',
        id: doc.documentID,
        strength: doc.data['strength'] ?? 0,
        addr1: doc.data['addr1'] ?? '0',
        addr2: doc.data['addr2'] ?? '0',
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']
    );
  }

  // get brews stream
  Stream<List<Vendor>> get vendors {
    //print(vendorCollection.getDocuments());
    return vendorCollection.snapshots()
        .map(_vendorListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}