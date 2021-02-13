import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sultan_pizza/bloc/pizzaInfo/pizzainfo_bloc.dart';
import 'package:sultan_pizza/config/constants.dart';
import 'package:sultan_pizza/model/sultan_pizza.dart';

class PizzaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Sultan pizza = ModalRoute.of(context).settings.arguments;
    BlocProvider.of<PizzainfoBloc>(context).add(CheckingItemCart(pizza));
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: kSecondColor),
      ),
      body: Column(
        children: [
          pizzaImage(context, pizza.url),
          BlocBuilder<PizzainfoBloc, PizzainfoState>(
            builder: (context, state) {
              if (state is AddingToCartFailed)
                return Expanded(
                  child: pizzaInfo(
                    context,
                    pizza,
                    '!اضف الى عربتك الان',
                    Color(0xFFFFC61F),
                  ),
                );
              else if (state is AddingToCartSucessful) {
                return Expanded(
                  child: pizzaInfo(
                    context,
                    pizza,
                    'تمت اضافته الى العربه',
                    Colors.grey,
                  ),
                );
              } else if (state is PizzainfoInitial) {
                return Expanded(
                  child: pizzaInfo(
                    context,
                    pizza,
                    '!اضف الى عربتك الان',
                    Color(0xFFFFC61F),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget pizzaImage(context, url) {
    Size size = MediaQuery.of(context).size;
    return Image.network(
      url,
      height: size.height * 0.25,
      width: double.infinity,
      // it cover the 25% of total height
      fit: BoxFit.fill,
    );
  }

  Widget pizzaInfo(context, Sultan pizza, String buttonMessage, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kSecondColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Text(
              pizza.name,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontFamily: 'Tajwal', fontSize: 25.0, color: kMainColor),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'المكونات:',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontFamily: 'Tajwal', fontSize: 25.0, color: Colors.white),
          ),
          SizedBox(
            child: Divider(
              thickness: 1.0,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pizza.ingredients.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '${index + 1}- ${pizza.ingredients[index]}',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Tajwal',
                        fontSize: 20.0,
                        color: kMainColor),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            child: Divider(
              thickness: 1.0,
              color: Colors.white,
            ),
          ),
          Text(
            'السعر:',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontFamily: 'Tajwal', fontSize: 25.0, color: Colors.white),
          ),
          Text(
            pizza.price.toString(),
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontFamily: 'Tajwal', fontSize: 25.0, color: kMainColor),
          ),
          Material(
            color: color,
            borderRadius: BorderRadius.circular(15.0),
            child: MaterialButton(
              onPressed: () {
                BlocProvider.of<PizzainfoBloc>(context)
                    .add(AddingToCart(pizza));
              },
              child: ListTile(
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                title: Text(
                  buttonMessage,
                  style: TextStyle(
                      fontFamily: 'Tajwal',
                      fontSize: 25.0,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
