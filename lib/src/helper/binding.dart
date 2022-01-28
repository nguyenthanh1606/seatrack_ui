import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/controllers/_controller.dart';
import 'package:seatrack_ui/src/core/controllers/app_system_controller.dart';
import 'package:seatrack_ui/src/views/pages/alter/alter_page.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => NetworkViewModel());
    Get.lazyPut(() => DeviceController());
    Get.lazyPut(() => AppSystemController());
    Get.lazyPut(() => ReportController());
  }
}
