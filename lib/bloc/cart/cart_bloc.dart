import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floor/floor.dart';
import 'package:sultan_pizza/model/sultan_cart.dart';
import 'package:sultan_pizza/service/database/dao/sultan_cart_dao.dart';
import 'package:sultan_pizza/service/database/database.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());
  List<SultanCart> myCart = List<SultanCart>();
  SultanCartDao sultanCartDao;
  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    yield CartLoading();
    if (event is GettingCartInfo) {
      FirebaseAuth mAuth = FirebaseAuth.instance;
      final database =
          await $FloorSultanDatabase.databaseBuilder('Sultan.db').build();
      sultanCartDao = database.sultanCartDao;
      myCart = await sultanCartDao.selectAllItems(mAuth.currentUser.email);
      yield CartLoaded(myCart);
    } else if (event is AddQuantity) {
      myCart[event.index].quantity++;
      yield CartLoaded(myCart);
    } else if (event is SubtractQuantity) {
      if (myCart[event.index].quantity != 1) {
        myCart[event.index].quantity--;
      }

      yield CartLoaded(myCart);
    } else if (event is RemoveItem) {
      FirebaseAuth mAuth = FirebaseAuth.instance;
      myCart.removeAt(event.index);
      await sultanCartDao.deleteOneItem(
          event.sultan.name, mAuth.currentUser.email);
      yield CartLoaded(myCart);
    }
  }

  int calculateTotalCost() {
    int sum = 0;
    for (int i = 0; i < myCart.length; i++) {
      sum += myCart[i].price * myCart[i].quantity;
    }
    return sum;
  }
}
