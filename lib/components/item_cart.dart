import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sultan_pizza/bloc/cart/cart_bloc.dart';
import 'package:sultan_pizza/config/constants.dart';
import 'package:sultan_pizza/model/sultan_cart.dart';

class ItemCart extends StatefulWidget {
  final int index;
  final SultanCart myPizza;
  ItemCart(this.index, this.myPizza);
  @override
  _ItemCartState createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  // int counter=0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: kSecondColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              child: Image.network(widget.myPizza.image),
              borderRadius: BorderRadius.circular(10.0),
              elevation: 10.0,
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  widget.myPizza.name,
                  style: TextStyle(
                      fontFamily: 'Tajwal',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${widget.myPizza.price.toString()} جنيه',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(AddQuantity(widget.index));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Center(
                            child: Icon(Icons.add),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${widget.myPizza.quantity.toString()}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(SubtractQuantity(widget.index));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Center(
                            child: Icon(Icons.remove),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(RemoveItem(widget.index, widget.myPizza));
                        },
                        child: Container(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
