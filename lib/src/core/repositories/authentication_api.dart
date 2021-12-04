import 'dart:convert';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/cupertino.dart';
import 'package:seatrack_ui/src/models/user_model.dart';

import 'endpoints_sea.dart';
import 'request_api.dart';

class AuthAPI {
  static Future<dynamic> signInWithUserAndPassword(
      String username, String password) async {
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'ClientIP': await Ipify.ipv4(),
    };
    Map<String, dynamic> user = {
      'UserName_': username,
      'pass_': password,
      'type_': 3,
    };
    final response =
        await postRequest(Uri.parse(Endpoints.login()), headers, user);
    return json.decode(response.body);
  }
}
