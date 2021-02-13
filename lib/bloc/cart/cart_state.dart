part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {
  const CartLoading();
  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final List<SultanCart> cartItems;
  const CartLoaded(this.cartItems);
  @override
  List<Object> get props => [cartItems];
}
