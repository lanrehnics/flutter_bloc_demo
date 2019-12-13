import 'package:flutter/material.dart';
import 'package:flutter_bloc_login/bloc/auth_bloc.dart';
import 'package:flutter_bloc_login/bloc/login_bloc.dart';
import 'package:flutter_bloc_login/events/login_event.dart';
import 'package:flutter_bloc_login/repository/user_repo.dart';
import 'package:flutter_bloc_login/states/login_state.dart';
import 'package:flutter_bloc_login/widgets/button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as FlutterBloc;

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  AuthenticationBloc _authenticationBloc;
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _authenticationBloc =
        FlutterBloc.BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return FlutterBloc.BlocBuilder<LoginBloc, LoginState>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is AfterLoginReset) {}
        if (state is LoginLoading) {
          isLoadingNotifier.value = true;
        }
        if (state is LoginFailure) {
          isLoadingNotifier.value = false;
          _scaffoldKey.currentState.showSnackBar(new SnackBar(
              backgroundColor: Colors.red,
              content: new Text(
                "Error",
                style: TextStyle(color: Colors.white),
              )));
        }
        return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0.0,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              backgroundColor: Colors.white,
              title: Text(
                'Sign In',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
            ),
            body: Center(
              child: Container(
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          elevation: 20.0,
                          child: Container(
                            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: _buildEmailTextField(),
                                    ),
                                    Divider(),
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: _buildPasswordTextField())
                                  ],
                                )),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      ValueListenableBuilder(
                        valueListenable: isLoadingNotifier,
                        builder: (context, bool isLoading, Widget child) {
                          return isLoading
                              ? SpinKitThreeBounce(
                                  color: Theme.of(context).primaryColor)
                              : InkWell(
                                  onTap: () {
                                    if (!(_formKey.currentState.validate())) {
                                      return;
                                    }
                                    _formKey.currentState.save();
                                    _loginBloc.add(LoginButtonPressed(
                                        email: _formData["email"],
                                        password: _formData["password"]));
                                  },
                                  child: TacButton(title: 'SIGN IN'));
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                          onTap: () {
//                        Navigator.of(context).push(MaterialPageRoute(
//                            builder: (context) => ResetPassword()));
                          },
                          child: Text('Forgot Password ?',
                              style: TextStyle(fontSize: 15.0))),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Don't have account ?",
                          style: TextStyle(fontSize: 15.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () {
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) => RegisterPage()));
                        },
                        child: Text("SIGN UP",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 400.0,
                  ),
                ),
                alignment: Alignment.center,
              ),
            ));
      },
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(Icons.person_outline),
          border: InputBorder.none,
          labelText: 'EMAIL ADDRESS',
          filled: true,
          fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(Icons.lock_outline),
          border: InputBorder.none,
          labelText: 'PASSWORD',
          filled: true,
          fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }
}
