import 'dart:async';

import 'package:flutter_bloc_login/events/auth_event.dart';
import 'package:flutter_bloc_login/repository/user_repo.dart';
import 'package:flutter_bloc_login/states/auth_state.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
//    AuthenticationState currentState,
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      bool hasToken = await userRepository.hasTokenAndNotExpired();

      if (hasToken) {
        //TODO fetch token and search
        yield AuthenticationAuthenticated(token: "SAVE CACHED TOKEN HERE");
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated(token: event.token);
    }

    if (event is LoggedOut) {
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
