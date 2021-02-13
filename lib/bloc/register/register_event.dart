part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class GoingToRegisterPage extends RegisterEvent {
  const GoingToRegisterPage();
  @override
  List<Object> get props => [];
}

class RegisterButtonClicked extends RegisterEvent {
  final Account account;
  const RegisterButtonClicked(this.account);

  @override
  List<Object> get props => [account];
}
