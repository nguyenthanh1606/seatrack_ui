import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<Response> getRequest(
  Uri url,
  Map<String, String> headers,
) async {
  final _client = http.Client();
  Response response =
      await _client.get(url, headers: headers).whenComplete(_client.close);
  return response;
}

Future<Response> postRequest(
    Uri url, Map<String, String> headers, Map<String, dynamic> body) async {
  final _client = http.Client();
  Response response = await _client
      .post(url, body: json.encode(body), headers: headers)
      .whenComplete(_client.close);
  return response;
}
