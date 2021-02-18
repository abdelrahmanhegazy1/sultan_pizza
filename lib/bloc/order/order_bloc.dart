import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sultan_pizza/model/account.dart';
import 'package:sultan_pizza/model/sultan_cart.dart';
import 'package:sultan_pizza/service/database/dao/sultan_cart_dao.dart';
import 'package:sultan_pizza/service/database/database.dart';
import 'package:sultan_pizza/service/firebase/firebase_manger.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState(0));
  int current = 0;
  Marker marker;
  String finalAddress = 'لم يتم اختيار المكان بعد';
  String phoneNumber;
  FirebaseManger firebaseManger = FirebaseManger();
  FirebaseAuth mAuth = FirebaseAuth.instance;
  Account myAccount;
  List<SultanCart> finalOrder;
  int price;
  SultanCartDao sultanCartDao;
  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is ContinueEvent) {
      if (current != 2) {
        myAccount =
            await firebaseManger.getUserInformation(mAuth.currentUser.email);
        if (current == 1 && marker != null) {
          print('hello lol ${marker.position.longitude}');
          current++;
          yield OrderState(current);
        } else if (current == 1 && marker == null)
          yield OrderFailure('عذرا يجب ان تختار مكان التوصيل');
        else {
          current++;
          yield OrderState(current);
        }
      } else {
        await firebaseManger.writeOrderDetails(finalOrder, finalAddress, price);
        final database =
            await $FloorSultanDatabase.databaseBuilder('Sultan.db').build();
        sultanCartDao = database.sultanCartDao;
        await sultanCartDao.deleteFromCart(mAuth.currentUser.email);
        current = 0;
        finalAddress = "لم يتم اختيار المكان بعد";
        marker = null;

        yield OrderCompleted();
      }
    } else if (event is CancelEvent) {
      if (current != 0) {
        current--;
        yield OrderState(current);
      }
    } else if (event is SendMarker) {
      marker = event.marker;
      Coordinates coordinates =
          Coordinates(marker.position.latitude, marker.position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      finalAddress = addresses.first.addressLine;
      // yield OrderState(current);
    }
  }
}
