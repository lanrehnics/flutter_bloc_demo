import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({
    @required this.email,
    @required this.password,
  }) : super([email, password]);

  @override
  String toString() => 'LoginButtonPressed { username: $email}';

  @override
  // TODO: implement props
  List<Object> get props => [email, password];
}

class Logout extends LoginEvent {
  @override
  String toString() => 'Logout';

  @override
  List<Object> get props => null;
}

class ResetLogin extends LoginEvent {
  @override
  String toString() => 'ResetLogin';

  @override
  List<Object> get props => null;
}
