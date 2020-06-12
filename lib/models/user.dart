class User {
  final String uid;

  User({ this.uid });
}

class UserData {
  String uid;
  String email;
  String name;
  String addr1;
  String addr2;
  String phoneNo;
  String cartVendor;
  double cartVal;

  UserData({ this.uid, this.email, this.name, this.addr1, this.addr2, this.phoneNo, this.cartVendor, this.cartVal });

  factory UserData.initialData() {
    return UserData(
      uid: '',
      email: '',
      name: '',
      addr1: '',
      addr2: '',
      phoneNo: '',
      cartVendor: '',
      cartVal: 0.0,
    );
  }
}