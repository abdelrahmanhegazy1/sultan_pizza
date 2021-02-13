part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GettingCartInfo extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddQuantity extends CartEvent {
  final int index;
  const AddQuantity(this.index);
  @override
  List<Object> get props => [index];
}

class SubtractQuantity extends CartEvent {
  final int index;
  const SubtractQuantity(this.index);
  @override
  List<Object> get props => [index];
}

class RemoveItem extends CartEvent {
  final int index;
  const RemoveItem(this.index);
  @override
  List<Object> get props => [index];
}
