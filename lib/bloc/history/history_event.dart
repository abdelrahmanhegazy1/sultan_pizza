part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class InitializeData extends HistoryEvent {
  const InitializeData();
  @override
  List<Object> get props => [];
}
