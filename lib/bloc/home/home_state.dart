part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  final List<Sultan> myMenuHelw;
  final List<Sultan> myMenuPizzaItaly;
  final List<Sultan> myMenuPizzaSharky;
  final List<Sultan> myMenuEftakast;
  final List<Sultan> myMenuFeter;
  const HomeLoaded(
      {this.myMenuEftakast,
      this.myMenuFeter,
      this.myMenuHelw,
      this.myMenuPizzaItaly,
      this.myMenuPizzaSharky});

  @override
  List<Object> get props => [
        myMenuEftakast,
        myMenuFeter,
        myMenuPizzaItaly,
        myMenuPizzaSharky,
        myMenuHelw
      ];
}

class GoingToProfile extends HomeState {
  final Sultan pizza;
  const GoingToProfile(this.pizza);
  @override
  List<Object> get props => [pizza];
}

class NavigateToScreen extends HomeState {
  final Widget myWidget;
  const NavigateToScreen(this.myWidget);
  @override
  List<Object> get props => [myWidget];
}
