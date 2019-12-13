import 'dart:convert';
import 'package:flutter_bloc_login/models/login_response.dart';
import 'package:meta/meta.dart';

class UserRepository {
  Future<LoginResponse> authenticate(
      {@required String email, @required String password}) async {
    Map<String, dynamic> params = {
      'code': email,
      'pass_code': password,
    };

//    Response response = await networkUtil.dioPost(Config.LOGIN, params, useSystemLogOut: false);

//    if ((response?.statusCode ?? 400) <= 201) {
//      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
//
//      if (response.statusCode <= 201) {
//        return loginResponse;
//      }
//      throw loginResponse.message;
//    } else
//      throw response?.data  != null
//          ? response?.data['message']
//          : 'Oops something went wrong!! Check your internet connection and retry';

    return LoginResponse(message: "Success", success: true);
  }

  Future<void> deleteToken() async {
    //TODO Delete token and logout
    return;
  }

  Future<void> persistToken(String token) async {
    // TODO Save Token here
    return;
  }

  Future<bool> hasTokenAndNotExpired() async {
    //TODO Validate if token exist and not expired

    return false;
  }
}
