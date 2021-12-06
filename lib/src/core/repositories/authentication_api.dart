import 'dart:convert';
import 'endpoints_khn.dart';
import 'request_api.dart';

class AuthAPI {
  static Future<dynamic> signInWithUserAndPassword(
      String username, String password) async {
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };
    Map<String, dynamic> user = {
      'UserName': username,
      '_Password': password,
    };
    final response =
        await postRequest(Uri.parse(Endpoints.login()), headers, user);
    return json.decode(response.body);
  }
}
