part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();

  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();

  @override
  List<Object> get props => [];
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess();

  @override
  List<Object> get props => [];
}

class RegisterFailed extends RegisterState {
  final String message;

  const RegisterFailed(this.message);
  @override
  List<Object> get props => [message];
}

class OpenRegisterPage extends RegisterState {
  const OpenRegisterPage();
  @override
  List<Object> get props => [];
}
