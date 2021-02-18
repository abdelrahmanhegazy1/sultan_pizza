part of 'order_bloc.dart';

class OrderState extends Equatable {
  final int step;
  const OrderState(this.step);

  @override
  List<Object> get props => [step];
}

class OrderFailure extends OrderState {
  final String error;
  const OrderFailure(this.error) : super(1);
  @override
  List<Object> get props => [error];
}

class OrderCompleted extends OrderState {
  const OrderCompleted() : super(0);
  @override
  List<Object> get props => [];
}
