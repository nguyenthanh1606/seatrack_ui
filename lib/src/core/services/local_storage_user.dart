import 'package:flutter/cupertino.dart';
import 'package:seatrack_ui/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageUser {
  static setUserData(PrefsUser prefsUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(prefsUser.toJson()));
  }

  static Future<PrefsUser?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      return PrefsUser.fromJson(
          json.decode(prefs.getString('user')!) as Map<String, dynamic>);
    }
    return null;
  }

  static clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  static setLastUser(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastU', username);
  }

  static Future<String?> getLastUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('lastU') != null) {
      return prefs.getString('lastU').toString();
    }
    return null;
  }
}
