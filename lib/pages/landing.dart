import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_login/bloc/auth_bloc.dart';
import 'package:flutter_bloc_login/bloc/login_bloc.dart';
import 'package:flutter_bloc_login/events/auth_event.dart';
import 'package:flutter_bloc_login/pages/home.dart';
import 'package:flutter_bloc_login/pages/login.dart';
import 'package:flutter_bloc_login/repository/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as FlutterBlocProvider;
import 'package:flutter_bloc_login/states/auth_state.dart';

class LandingPage extends StatefulWidget {
  final UserRepository userRepository;

  LandingPage({Key key, @required this.userRepository}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<StatefulWidget> createState() {
    return _LandingPageState();
  }
}

class _LandingPageState extends State<LandingPage> {
  AuthenticationBloc authenticationBloc;
  LoginBloc _loginBloc;
  StreamSubscription logoutSub;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    _loginBloc = LoginBloc(
      userRepository: UserRepository(),
      authenticationBloc: authenticationBloc,
    );
    authenticationBloc.add(AppStarted());

    super.initState();
  }

  UserRepository get userRepository => widget.userRepository;

  @override
  Widget build(BuildContext context) {
    return FlutterBlocProvider.BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) => authenticationBloc,
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0XFF242B88),
            primaryColorLight: MaterialColor(0XFF5B7FE1, color),
            accentColor: Color(0XFFFFFCAB31),
            primarySwatch: MaterialColor(0XFF5B7FE1, color),
            buttonColor: Color(0xff3C3C3C),
            fontFamily: 'Avenir'),
        debugShowCheckedModeBanner: false,
        home: FlutterBlocProvider.BlocBuilder<AuthenticationBloc,
            AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return LoginPage(userRepository: userRepository);
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: userRepository);
            }
            if (state is AuthenticationLoading) {
              return Container(width: 0.0, height: 0.0);
            }
            return Container(width: 0, height: 0);
          },
        ),
      ),
    );

//            SessionManager.isLoggedIn ?? false ?  : );
  }

  @override
  void dispose() {
    authenticationBloc.close();
    super.dispose();
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
//    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
//    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
//    print(error);
  }
}

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
