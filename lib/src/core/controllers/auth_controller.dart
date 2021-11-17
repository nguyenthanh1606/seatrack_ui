import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/services/local_storage_user.dart';
import 'package:seatrack_ui/src/models/user_model.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  late TextEditingController usernameController, passwordController;
  var username = '';
  var password = '';

  UserModel? _currentUser;
  String? get user => _currentUser?.username;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  String? validateUsername(String value) {
    if (value.length < 6 || value.length > 30) {
      return "Username must be of 6 characters";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6 || value.length > 30) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  getCurrentUser() async {
    _currentUser = await LocalStorageUser.getUserData();
    update();
  }

  void signOut() async {
    try {
      LocalStorageUser.clearUserData();
    } catch (error) {
      print(error);
    }
  }

  void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
  }
  // void saveUser(UserCredential userCredential) async {
  //   UserModel _userModel = UserModel(
  //     userId: userCredential.user!.uid,
  //     email: userCredential.user!.email!,
  //     name: name == null ? userCredential.user!.displayName! : this.name!,
  //     pic: userCredential.user!.photoURL == null
  //         ? 'default'
  //         : userCredential.user!.photoURL! + "?width=400",
  //   );
  //   saveUserLocal(_userModel);
  // }

  // void saveUserLocal(UserModel userModel) async {
  //   LocalStorageUser.setUserData(userModel);
  // }
}
