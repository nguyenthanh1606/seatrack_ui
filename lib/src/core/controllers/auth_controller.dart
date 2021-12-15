import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/repositories/authentication_api.dart';
import 'package:seatrack_ui/src/core/repositories/user_api.dart';
import 'package:seatrack_ui/src/core/services/local_storage_user.dart';
import 'package:seatrack_ui/src/models/user_model.dart';
import 'package:seatrack_ui/src/views/pages/control_page.dart';

class AuthController extends GetxController {
  bool _passwordVisible = true;
  bool _loading = false;
  late String token;

  bool get loading => _loading;
  String? username, password;

  bool? get passwordVisible => _passwordVisible;
  UserModel? _currentUser;
  String? get user => _currentUser?.username;
  @override
  void onInit() {
    debugPrint('AuthController onInit');
    super.onInit();
  }

  @override
  void onClose() {
    debugPrint('AuthController onClose');
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
      Get.offAll(() => ControlPage());
    } catch (error) {
      print(error);
    }
  }

  void signInWithUserAndPassword() async {
    _loading = true;
    update();
    try {
      await AuthAPI.signInWithUserAndPassword(username!, password!).then((res) {
        debugPrint(res['token'].toString());
        // debugPrint(res.toString());
        if (res['status'] == 400) {
          throw 'Error Tên đăng nhập hoặc mật khẩu không chính xác';
        } else {
          UserModel user = UserModel(username: username!, token: res['token']);
          saveUserLocal(user);
        }
      });

      await getCurrentUser();
      Get.offAll(() => ControlPage());
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to login..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    _loading = false;
    update();
  }
  // void saveUser(UserCredential userCredential) async {
  //   UserInfoModel _userModel = UserInfoModel(
  //     userId: userCredential.user!.uid,
  //     email: userCredential.user!.email!,
  //     name: name == null ? userCredential.user!.displayName! : this.name!,
  //     pic: userCredential.user!.photoURL == null
  //         ? 'default'
  //         : userCredential.user!.photoURL! + "?width=400",
  //   );
  //   saveUserLocal(_userModel);
  // }

  void saveUserLocal(UserModel prefsUser) async {
    LocalStorageUser.setUserData(prefsUser);
  }

  void togglePasswordVisible() {
    _passwordVisible = !_passwordVisible;
    update();
  }
}
