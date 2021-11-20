import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/services/local_storage_user.dart';
import 'package:seatrack_ui/src/models/user_model.dart';
import 'package:seatrack_ui/src/views/pages/control_page.dart';

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
      await LocalStorageUser.clearUserData();
      _currentUser = null;
      update();
      Get.offAll(() => const ControlPage());
    } catch (error) {
      print(error);
    }
  }

  void signInWithUsernameAndPassword() async {
    try {
      UserModel user = UserModel(
          username: usernameController.text,
          password: passwordController.text,
          token: '11111');
      saveUserLocal(user);
      await getCurrentUser();
      Get.offAll(() => const ControlPage());
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to login..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
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

  void saveUserLocal(UserModel userModel) async {
    LocalStorageUser.setUserData(userModel);
  }
}
