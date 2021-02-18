import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sultan_pizza/bloc/cart/cart_bloc.dart';
import 'package:sultan_pizza/bloc/history/history_bloc.dart';
import 'package:sultan_pizza/bloc/home/home_bloc.dart';
import 'package:sultan_pizza/bloc/login/login_bloc.dart';
import 'package:sultan_pizza/bloc/order/order_bloc.dart';
import 'package:sultan_pizza/bloc/pizzaInfo/pizzainfo_bloc.dart';
import 'package:sultan_pizza/bloc/register/register_bloc.dart';
import 'package:sultan_pizza/config/constants.dart';
import 'package:sultan_pizza/screen/cart.dart';
import 'package:sultan_pizza/screen/history.dart';
import 'package:sultan_pizza/screen/home.dart';
import 'package:sultan_pizza/screen/login.dart';
import 'package:sultan_pizza/screen/order.dart';
import 'package:sultan_pizza/screen/pizza_profile.dart';
import 'package:sultan_pizza/screen/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<RegisterBloc>(create: (context) => RegisterBloc()),
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
      ),
      BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
      BlocProvider<PizzainfoBloc>(
        create: (context) => PizzainfoBloc(),
      ),
      BlocProvider<CartBloc>(
        create: (context) => CartBloc(),
      ),
      BlocProvider<OrderBloc>(
        create: (context) => OrderBloc(),
      ),
      BlocProvider<HistoryBloc>(
        create: (context) => HistoryBloc(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: kMainColor,
        accentColor: kSecondColor,
      ),
      initialRoute: kLogin_Screen,
      routes: {
        kLogin_Screen: (context) => LoginScreen(),
        kRegister_Screen: (context) => RegisterScreen(),
        kHome_Screen: (context) => HomeScreen(),
        kPizza_Screen: (context) => PizzaScreen(),
        kCart_Screen: (context) => CartScreen(),
        kOrder_Screen: (context) => OrderScreen(),
        kHistory_Screen: (context) => HistoryScreen()
      },
      title: 'Flutter Demo',
    );
  }
}
