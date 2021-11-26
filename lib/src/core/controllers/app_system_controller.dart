import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/services/local_storage_map.dart';
import 'package:seatrack_ui/src/models/mock/app_mock.dart';

class AppSystemController extends GetxController {
  String? mName;
  // final AppSystemMock? _currentAppSystem = getMap() as AppSystemMock?;
  String? get typeMap => getMName().toString();

  @override
  void onInit() {
    getMName();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<String> getMName() async {
    return mName = await getMap();
  }
  // void saveUserLocal(UserModel userModel) async {
  //   LocalStorageUser.setUserData(userModel);
  // }
}
