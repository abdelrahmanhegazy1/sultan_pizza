import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sultan_pizza/bloc/order/order_bloc.dart';
import 'package:sultan_pizza/config/constants.dart';
import 'package:sultan_pizza/model/account.dart';
import 'package:sultan_pizza/model/sultan_cart.dart';

class ConfirmOrder extends StatelessWidget {
  final List<SultanCart> myCart;
  final int price;

  ConfirmOrder({this.myCart, this.price});
  @override
  Widget build(BuildContext context) {
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${orderBloc.myAccount.username} :الاسم',
              style: TextStyle(
                  fontFamily: 'Tajwal',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    '${orderBloc.finalAddress}',
                    style: TextStyle(
                        fontFamily: 'Tajwal',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  ' :العنوان',
                  style: TextStyle(
                      fontFamily: 'Tajwal',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              'رقم التليفون الخاص بك هو: ${orderBloc.myAccount.number}',
              style: TextStyle(
                  fontFamily: 'Tajwal',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'سعر الطلب: ${price} جنيه',
              style: TextStyle(
                  fontFamily: 'Tajwal',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'سيستغرق الطلب للوصول من نصف ساعه الى ساعه شكرا لاختيارك بيتزا السلطان',
              style: TextStyle(
                  fontFamily: 'Tajwal',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
