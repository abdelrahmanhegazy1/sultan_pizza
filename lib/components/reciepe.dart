import 'package:flutter/material.dart';
import 'package:sultan_pizza/components/item_cart.dart';
import 'package:sultan_pizza/components/item_order.dart';
import 'package:sultan_pizza/config/constants.dart';
import 'package:sultan_pizza/model/sultan_cart.dart';

class Reciepe extends StatelessWidget {
  final List<SultanCart> myCart;
  final int price;
  Reciepe(this.myCart, this.price);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * (0.95),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: myCart.length,
              itemBuilder: (context, index) {
                return ItemOrder(myCart[index]);
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'خدمة التوصيل:20 جنيه',
            style: TextStyle(
                fontFamily: 'Tajwal',
                fontSize: 20.0,
                color: kSecondColor,
                fontWeight: FontWeight.w800),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'الاجمالي: ${price + 20} جنيه',
            style: TextStyle(
                fontFamily: 'Tajwal',
                fontSize: 20.0,
                color: kSecondColor,
                fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
