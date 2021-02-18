import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sultan_pizza/model/history_order.dart';
import 'package:sultan_pizza/service/firebase/firebase_manger.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial());
  List<HistoryOrder> allOrders = List<HistoryOrder>();
  FirebaseManger firebaseManger = FirebaseManger();

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    yield HistoryInitial();
    if (event is InitializeData) {
      allOrders = await firebaseManger.getOldHistory();
      print(allOrders[0].foodList[0].name);
      yield HistoryLoaded(allOrders);
    }
  }
}
