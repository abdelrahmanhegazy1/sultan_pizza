import 'package:sultan_pizza/model/sultan_cart.dart';

class HistoryOrder {
  List<SultanCart> foodList;
  String time;
  String price;
  String address;

  HistoryOrder({this.address, this.foodList, this.price, this.time});
}
