import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sultan_pizza/model/sultan_pizza.dart';
import 'package:sultan_pizza/screen/cart.dart';
import 'package:sultan_pizza/service/firebase/firebase_manger.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  FirebaseManger firebaseManger = FirebaseManger();
  List<Sultan> myMenuHelw = List<Sultan>();
  List<Sultan> myMenuPizzaItaly = List<Sultan>();
  List<Sultan> myMenuPizzaSharky = List<Sultan>();
  List<Sultan> myMenuEftakast = List<Sultan>();
  List<Sultan> myMenuFeter = List<Sultan>();
  int currentIndex = 0;

  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    yield HomeLoading();
    if (event is Load) {
      myMenuHelw = await firebaseManger.getSultanMenuOption('helw');
      myMenuFeter = await firebaseManger.getSultanMenuOption('feter');
      myMenuPizzaSharky =
          await firebaseManger.getSultanMenuOption('pizza_sharky');
      myMenuEftakast =
          await firebaseManger.getSultanMenuOption('eftkasat_sultan');
      myMenuPizzaItaly =
          await firebaseManger.getSultanMenuOption('pizza_italy');

      yield HomeLoaded(
          myMenuEftakast: myMenuEftakast,
          myMenuFeter: myMenuFeter,
          myMenuHelw: myMenuHelw,
          myMenuPizzaItaly: myMenuPizzaItaly,
          myMenuPizzaSharky: myMenuPizzaSharky);
    } else if (event is ItemClicked) {
      yield GoingToProfile(event.pizza);
    } else if (event is NavigationClicked) {
      if (event.index == 0) {
        yield NavigateToScreen(CartScreen());
      } else if (event.index == 1) {
        //waiting for new screens Soon
        yield NavigateToScreen(CartScreen());
      }
    }
  }
}
