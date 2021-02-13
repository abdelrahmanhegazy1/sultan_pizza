import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sultan_pizza/bloc/cart/cart_bloc.dart';
import 'package:sultan_pizza/components/item_cart.dart';
import 'package:sultan_pizza/config/constants.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(GettingCartInfo());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kSecondColor),
        centerTitle: true,
        title: Text(
          'عربة التسوق',
          style: TextStyle(
              fontFamily: 'Tajwal',
              fontSize: 20.0,
              color: kSecondColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0), color: Colors.white),
          child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartLoading) {
              return buildProgressBar(context);
            } else if (state is CartLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ItemCart(index, state.cartItems[index]);
                },
                itemCount: state.cartItems.length,
              );
            } else if (state is CartInitial) {
              return buildProgressBar(context);
            }
          }),
        ),
      ),
    );
  }

  Widget buildProgressBar(context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}
