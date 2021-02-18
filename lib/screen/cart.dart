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
              if (state.cartItems.length == 0)
                return Center(
                  child: Text('🛒 العربه فارغه',
                      style: TextStyle(
                          fontFamily: 'Tajwal',
                          fontSize: 30.0,
                          color: kSecondColor,
                          fontWeight: FontWeight.bold)),
                );
              else
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ItemCart(index, state.cartItems[index]);
                        },
                        itemCount: state.cartItems.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: Material(
                        color: Color(0xFFFFC61F),
                        borderRadius: BorderRadius.circular(10.0),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, kOrder_Screen,
                                arguments: {
                                  'cost': BlocProvider.of<CartBloc>(context)
                                      .calculateTotalCost(),
                                  'cart':
                                      BlocProvider.of<CartBloc>(context).myCart
                                });
                          },
                          child: Center(
                            child: Text(
                              '🛒  اطلب الان',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Tajwal',
                                  fontSize: 25.0),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
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
