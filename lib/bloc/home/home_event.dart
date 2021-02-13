part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class Load extends HomeEvent {
  final String type;
  const Load(this.type);
  @override
  List<Object> get props => [type];
}

class ItemClicked extends HomeEvent {
  final Sultan pizza;
  const ItemClicked(this.pizza);
  @override
  List<Object> get props => [pizza];
}

class NavigationClicked extends HomeEvent {
  final int index;
  const NavigationClicked(this.index);
  @override
  List<Object> get props => [index];
}
