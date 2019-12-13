import 'package:flutter/material.dart';
import 'package:countdown/countdown.dart';
import 'package:flutter_bloc_login/bloc/auth_bloc.dart';
import 'package:flutter_bloc_login/events/auth_event.dart';
import 'package:flutter_bloc_login/pages/fancy.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as FlutterBloc;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  ValueNotifier<String> countDownNotifier = ValueNotifier("0");
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc =
        FlutterBloc.BlocProvider.of<AuthenticationBloc>(context);

    CountDown cd = CountDown(Duration(seconds: 10));
    var sub = cd.stream.listen(null);

    // start your countdown by registering a listener
    sub.onData((Duration d) {
      countDownNotifier.value = [d.inHours, d.inMinutes, d.inSeconds]
          .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
          .join(':');
    });

    // when it finish the onDone cb is called
    sub.onDone(() {
      _authenticationBloc.add(LoggedOut());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FancyBackgroundApp(),
          Center(
              child: ValueListenableBuilder(
            valueListenable: countDownNotifier,
            builder: (context, String value, Widget child) {
              return Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white),
              );
            },
          )),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
