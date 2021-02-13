part of 'pizzainfo_bloc.dart';

abstract class PizzainfoEvent extends Equatable {
  const PizzainfoEvent();

  @override
  List<Object> get props => [];
}

class AddingToCart extends PizzainfoEvent {
  final Sultan orderItem;
  const AddingToCart(this.orderItem);
  @override
  List<Object> get props => [orderItem];
}

class CheckingItemCart extends PizzainfoEvent {
  final Sultan item;
  const CheckingItemCart(this.item);
  @override
  List<Object> get props => [item];
}
