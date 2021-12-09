import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:seatrack_ui/src/core/services/local_storage_user.dart';
import 'package:seatrack_ui/src/models/user_model.dart';

import 'endpoints_khn.dart';
import 'request_api.dart';

class DeviceAPI {
  static Future<dynamic> getDeviceGroup() async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response =
        await getRequest(Uri.parse(Endpoints.getListGroup()), headers);
    return json.decode(response.body);
  }

  static Future<dynamic> getListDevieStage(groupid) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getListDeviceByGroupId(groupid)), headers);
    return json.decode(response.body);
  }

  static Future<dynamic> getDevieStageById(deviceId, isOpt) async {
    UserModel? prefsUser = await LocalStorageUser.getUserData();
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefsUser!.token}',
    };
    final response = await getRequest(
        Uri.parse(Endpoints.getDevieStageById(deviceId, isOpt)), headers);
    return json.decode(response.body);
  }
}
