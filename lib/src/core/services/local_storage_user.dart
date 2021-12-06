import 'package:flutter/cupertino.dart';
import 'package:seatrack_ui/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageUser {
  static setUserData(UserModel prefsUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(prefsUser.toJson()));
  }

  static Future<UserModel?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      return UserModel.fromJson(
          json.decode(prefs.getString('user')!) as Map<String, dynamic>);
    }
    return null;
  }

  static clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
