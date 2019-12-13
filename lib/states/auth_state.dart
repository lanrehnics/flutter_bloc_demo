import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_login/models/login_response.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super();
}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AuthenticationAuthenticated extends AuthenticationState {
  final String token;
  AuthenticationAuthenticated({@required this.token}) : super([token]);

  @override
  String toString() => 'AuthenticationAuthenticated { response: $token }';

  @override
  List<Object> get props => [token];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
