import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sultan_pizza/model/sultan_cart.dart';
import 'package:sultan_pizza/model/sultan_pizza.dart';
import 'package:floor/floor.dart';
import 'package:sultan_pizza/service/database/dao/sultan_cart_dao.dart';
import 'package:sultan_pizza/service/database/database.dart';
part 'pizzainfo_event.dart';
part 'pizzainfo_state.dart';

class PizzainfoBloc extends Bloc<PizzainfoEvent, PizzainfoState> {
  PizzainfoBloc() : super(PizzainfoInitial());
  List<SultanCart> myCart = List<SultanCart>();

  @override
  Stream<PizzainfoState> mapEventToState(
    PizzainfoEvent event,
  ) async* {
    FirebaseAuth mAuth = FirebaseAuth.instance;
    final database =
        await $FloorSultanDatabase.databaseBuilder('Sultan.db').build();
    final SultanCartDao sultanCartDao = database.sultanCartDao;
    myCart = await sultanCartDao.selectAllItems(mAuth.currentUser.email);
    if (event is AddingToCart) {
      SultanCart sultanCart = SultanCart(
          name: event.orderItem.name,
          email: mAuth.currentUser.email,
          image: event.orderItem.url,
          price: event.orderItem.price);
      try {
        await sultanCartDao.insertItemToCart(sultanCart);

        yield AddingToCartSucessful();
      } catch (e) {
        yield AddingToCartFailed(e);
      }
    }
    if (event is CheckingItemCart) {
      bool flag = false;
      for (int i = 0; i < myCart.length; i++) {
        if (event.item.name == myCart[i].name) {
          flag = true;
          break;
        }
      }
      if (flag)
        yield AddingToCartSucessful();
      else
        yield AddingToCartFailed('nothing');

      // print('my pizza is ${event.item.name}');

    }
  }
}
