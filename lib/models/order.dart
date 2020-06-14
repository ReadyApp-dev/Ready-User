class Order{
  Map<String,dynamic> cart;
  String status;
  double totalCost;
  String user;
  String vendor;
  String id;

  Order({this.id, this.status, this.cart, this.totalCost, this.user, this.vendor});
}