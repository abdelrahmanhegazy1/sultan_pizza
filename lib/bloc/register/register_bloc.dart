import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sultan_pizza/model/account.dart';
import 'package:sultan_pizza/service/firebase/firebase_manger.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseManger firebaseManger = FirebaseManger();
  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    yield RegisterLoading();
    if (event is GoingToRegisterPage) {
      yield OpenRegisterPage();
    } else if (event is RegisterButtonClicked) {
      bool registerDone = await firebaseManger.registerAccount(event.account);
      print('$registerDone');
      if (registerDone)
        yield RegisterSuccess();
      else
        yield RegisterFailed('Email is already registerd before!');
    }
  }
}
