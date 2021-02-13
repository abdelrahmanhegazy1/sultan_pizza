part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  const LoginLoading();
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final Account account;
  const LoginSuccess(this.account);
  @override
  List<Object> get props => [account];
}

class LoginFailed extends LoginState {
  final String message;
  const LoginFailed(this.message);
  @override
  List<Object> get props => [message];
}
