import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  bool _loading = false;
  DateTime? _start, _end;
  int? _deviceId;
  String? _vehicalNumber;

  bool get loading => _loading;
  DateTime? get start => _start;
  DateTime? get end => _end;
  int get deviceId => _deviceId!;
  String get vehicleNumber => _vehicalNumber!;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    debugPrint('ReportController onReady');
    super.onReady();
  }

  @override
  void onClose() {
    debugPrint('ReportController onClose');
    super.onClose();
  }

  void toggleSearchSuss() {
    _loading = !_loading;
    update();
  }

  void getListReportHistory(int deviceId, int type) {
    switch (type) {
      case 0:
        {
          _end = DateTime.now();
          _start = _end!.subtract(Duration(hours: 4));
          debugPrint('${_start} - ${_end} \n ${deviceId}');
          break;
        }
      case 1:
        {
          _end = DateTime.now();
          _start = _end!.subtract(Duration(hours: 8));
          debugPrint('${_start} - ${_end} \n ${deviceId}');
          break;
        }
      case 2:
        {
          _end = DateTime.now();
          _start = _end!.subtract(Duration(days: 1));
          debugPrint('${_start} - ${_end} \n ${deviceId}');
          break;
        }
      case 3:
        {
          debugPrint('${_start} - ${_end} \n ${deviceId}');
          break;
        }
    }
  }

  void setDateTime(DateTime dt, int type) {
    //type 0: start - 1: end
    switch (type) {
      case 0:
        _start = dt;
        break;
      case 1:
        _end = dt;
        break;
    }
    update();
  }
}
