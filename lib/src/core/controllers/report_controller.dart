import 'package:get/get.dart';

class ReportController extends GetxController {
  RxInt searchSuss = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void toggleSearchSuss() =>
      searchSuss.value == 0 ? searchSuss.value = 1 : searchSuss.value = 0;
}
