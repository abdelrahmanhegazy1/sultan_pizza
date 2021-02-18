part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class ContinueEvent extends OrderEvent {
  const ContinueEvent();
  @override
  List<Object> get props => [];
}

class CancelEvent extends OrderEvent {
  const CancelEvent();
  @override
  List<Object> get props => [];
}

class SendMarker extends OrderEvent {
  final Marker marker;
  const SendMarker(this.marker);
  @override
  List<Object> get props => [marker];
}
