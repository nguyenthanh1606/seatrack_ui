import 'dart:convert';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:seatrack_ui/src/core/repositories/endpoints_sea.dart';
import 'package:seatrack_ui/src/core/repositories/request_api.dart';

class UserAPI {
  static Future<dynamic> getInfoByUserName(
      String username, String token) async {
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'ClientIP': await Ipify.ipv4(),
      'ApiKey': token
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getInfoByUserName(username)), headers);
    return json.decode(response.body);
  }
}
