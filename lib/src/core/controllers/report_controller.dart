import 'dart:ui';

import 'package:get/get.dart';

class ReportController extends GetxController {
  bool _loading = false;
  bool get loading => _loading;
  @override
  void onInit() {
    print('ReportController onInit');
    super.onInit();
  }

  @override
  void onReady() {
    print('ReportController onReady');
    super.onReady();
  }

  @override
  void onClose() {
    print('ReportController onClose');
    super.onClose();
  }

  void toggleSearchSuss() {
    _loading = !_loading;
    update();
  }
}
