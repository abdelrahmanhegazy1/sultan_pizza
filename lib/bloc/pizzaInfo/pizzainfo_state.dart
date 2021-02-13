part of 'pizzainfo_bloc.dart';

abstract class PizzainfoState extends Equatable {
  const PizzainfoState();

  @override
  List<Object> get props => [];
}

class PizzainfoInitial extends PizzainfoState {}

class AddingToCartSucessful extends PizzainfoState {
  const AddingToCartSucessful();
  @override
  List<Object> get props => [];
}

class AddingToCartFailed extends PizzainfoState {
  final String message;
  const AddingToCartFailed(this.message);
  @override
  List<Object> get props => [message];
}
