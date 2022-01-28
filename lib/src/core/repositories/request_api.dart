import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:seatrack_ui/src/core/controllers/auth_controller.dart';

Future<Response> getRequest(
  Uri url,
  Map<String, String> headers,
) async {
  try {
    final _client = http.Client();
    Response response =
        await _client.get(url, headers: headers).whenComplete(_client.close);

    return response;
  } catch (e) {
    debugPrint('ERROR');
    Get.find<AuthController>().signOut();
    Response? response;
    return response!;
  }
}

Future<Response> postRequest(
    Uri url, Map<String, String> headers, Map<String, dynamic> body) async {
  try {
    final _client = http.Client();
    Response response = await _client
        .post(url, body: json.encode(body), headers: headers)
        .whenComplete(_client.close);
    return response;
  } catch (e) {
    debugPrint('ERROR');
    Get.find<AuthController>().signOut();
    Response? response;
    return response!;
  }
}
