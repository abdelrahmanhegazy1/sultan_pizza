part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoaded extends HistoryState {
  final List<HistoryOrder> allOrders;
  const HistoryLoaded(this.allOrders);
  @override
  List<Object> get props => [allOrders];
}
