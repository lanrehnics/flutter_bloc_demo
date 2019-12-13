import 'dart:async';
import 'package:flutter_bloc_login/events/auth_event.dart';
import 'package:flutter_bloc_login/events/login_event.dart';
import 'package:flutter_bloc_login/models/login_response.dart';
import 'package:flutter_bloc_login/repository/user_repo.dart';
import 'package:flutter_bloc_login/states/login_state.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'auth_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
//    LoginState currentState,
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      await Future.delayed(Duration(seconds: 10));

      try {
        final LoginResponse response = await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );
        authenticationBloc.add(LoggedIn(token: "TOKEN----"));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }

    if (event is Logout) {
      authenticationBloc.add(LoggedOut());
    }

    if (event is ResetLogin) {
      yield AfterLoginReset();
    }
  }
}
