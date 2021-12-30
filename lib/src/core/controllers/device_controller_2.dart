import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:map4d_map/map4d_map.dart';
import 'package:seatrack_ui/src/core/repositories/home_api.dart';
import 'package:seatrack_ui/src/models/device_model.dart';

class DeviceController2 extends GetxController {
  bool _loading = false;
  bool get loading => _loading;
  bool _isSearch = false;
  bool get isSearch => _isSearch;
  late int _currentGroupID;
  int _currentIndexGroup = 0;
  int get currentGroupID => _currentGroupID;
  int get currentIndexGroup => _currentIndexGroup;

  late List<DeviceGroupModel> listDGroup;
  List<DeviceLessModel>? _listSearch = null;
  List<DeviceLessModel>? get listSearch => _listSearch;
  DeviceStageModel? _dvStageCurent = null;
  DeviceStageModel? get dvStageCurent => _dvStageCurent;
  DeviceStageModel? _dvReportCurrent = null;
  DeviceStageModel? get dvReportCurrent => _dvReportCurrent;
  List<String> _searchTerms = [];
  List<String> get searchTerms => _searchTerms;
  Timer? _intervalData;

  DeviceStageModel? _infoDevice = null;
  DeviceStageModel? get infoDevice => _infoDevice;

  @override
  void onInit() {
    super.onInit();
    getDeviceGroup();
  }

  @override
  void onClose() {
    debugPrint('onClose');
    intervalCancel();
  }

  void getDeviceGroup() async {
    _loading = true;
    try {
      await DeviceAPI.getDeviceGroup().then((res) {
        listDGroup = List<DeviceGroupModel>.from(
            res.map((e) => DeviceGroupModel.fromJson(e)).toList());
      });
      _currentGroupID = listDGroup[_currentIndexGroup].vehicleGroupID;
      await DeviceAPI.getListDevieStage(_currentGroupID).then((res) {
        var listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());
        listDGroup[_currentIndexGroup].listDvStage = listDState;
      });
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

  Future<void> searchDvByNumber(String vehicleNumber) async {
    _loading = true;
    try {
      await DeviceAPI.getDevieStageByVNumber(vehicleNumber).then((res) {
        if (res.toString() != "[]") {
          _listSearch = List<DeviceLessModel>.from(
              res.map((e) => DeviceLessModel.fromJson(e)).toList());
        }
        debugPrint(_listSearch.toString());
      });
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Err ',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    _loading = false;
    update();
  }

  Future<DeviceStageModel> getDeviceInfo(deviceId) async {
    _loading = true;
    DeviceStageModel? result = null;
    await DeviceAPI.getDevieStageById(deviceId, true).then((res) async {
      result = DeviceStageModel.fromJson(res);
      result!.deviceInfo = DeviceInfoModel.fromJson(res);
    });
    _loading = false;
    update();
    return result!;
  }

  void setSearch(DeviceStageModel device) {
    // _isSearch = false;
    _dvStageCurent = device;
    update();
  }

  void setDeviceReport(int deviceId) {
    _dvReportCurrent = listDGroup[_currentIndexGroup]
        .listDvStage!
        .where((element) => element.deviceID == deviceId)
        .first;
    update();
  }

  Future<void> changeCurrentGroup(int vehicleGroupID) async {
    intervalCancel();
    _currentIndexGroup = listDGroup
        .indexWhere((element) => element.vehicleGroupID == vehicleGroupID);
    _currentGroupID = vehicleGroupID;
    if (listDGroup[_currentIndexGroup].listDvStage == null) {
      _loading = true;
      await getListDVStage();
      _loading = false;
    }
    _dvStageCurent = null;
    interval();
    update();
  }

  Future<void> getListDVStage() async {
    // _loading = true;
    await DeviceAPI.getListDevieStage(_currentGroupID).then((res) async {
      var listDState = List<DeviceStageModel>.from(
          res.map((e) => DeviceStageModel.fromJson(e)).toList());

      listDGroup[_currentIndexGroup].listDvStage = listDState;
    });
    // _loading = false;
    update();
  }

  void interval() {
    _intervalData = Timer.periodic(Duration(seconds: 20), (timer) {
      debugPrint('--------interval--------');
      getListDVStage();
      update();
    });
  }

  void intervalCancel() {
    debugPrint('--------intervalCancel--------');
    if (_intervalData != null) {
      _intervalData!.cancel();
    }
  }

  void openSearch() {
    _isSearch = true;
    update();
  }

  void closeSearch() {
    _isSearch = false;
    update();
  }
}
