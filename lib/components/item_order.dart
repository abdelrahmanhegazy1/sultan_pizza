import 'package:flutter/material.dart';
import 'package:sultan_pizza/config/constants.dart';
import 'package:sultan_pizza/model/sultan_cart.dart';

class ItemOrder extends StatelessWidget {
  final SultanCart pizza;
  ItemOrder(this.pizza);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: kSecondColor),
        child: Row(
          children: [
            Expanded(
              child: Image.network(
                pizza.image,
                height: 50.0,
                width: 50.0,
              ),
            ),
            Expanded(
              child: Text(
                'الكميه :${pizza.quantity}',
                style: TextStyle(
                    fontFamily: 'Tajwal',
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                'السعر :${pizza.price * pizza.quantity} جنيه',
                style: TextStyle(
                    fontFamily: 'Tajwal',
                    fontSize: 11.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                pizza.name,
                style: TextStyle(
                    fontFamily: 'Tajwal',
                    fontSize: 12.0,
                    color: kMainColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
