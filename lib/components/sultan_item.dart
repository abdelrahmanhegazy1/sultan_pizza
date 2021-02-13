import 'package:flutter/material.dart';
import 'package:sultan_pizza/model/sultan_pizza.dart';

class SultanItem extends StatelessWidget {
  final Sultan sultanPizza;
  SultanItem(this.sultanPizza);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: 240,
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Image.network(
              sultanPizza.url,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              sultanPizza.name,
              style: TextStyle(
                  fontFamily: 'Tajwal',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black),
              textDirection: TextDirection.rtl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              '${sultanPizza.price.toString()} جنيه',
              style: TextStyle(
                  fontFamily: 'Tajwal',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black),
              textDirection: TextDirection.rtl,
            ),
          )
        ],
      ),
    );
  }
}
