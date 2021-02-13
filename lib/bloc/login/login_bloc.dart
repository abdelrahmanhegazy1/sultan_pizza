import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sultan_pizza/model/account.dart';
import 'package:sultan_pizza/service/firebase/firebase_manger.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  FirebaseManger firebaseManger = FirebaseManger();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield LoginLoading();

    if (event is LoginButtonClicked) {
      Account account =
          await firebaseManger.loginAccount(event.email, event.password);
      if (account == null)
        yield LoginFailed('Your Username/Passwrod Incorrect');
      else
        yield LoginSuccess(account);
    }
  }
}
