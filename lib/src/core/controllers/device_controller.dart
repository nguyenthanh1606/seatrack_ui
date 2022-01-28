import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/repositories/home_api.dart';
import 'package:seatrack_ui/src/models/device_model.dart';

class DeviceController extends GetxController {
  Timer? _intervalCurrentData, _interval;
  bool _loading = false;
  bool get loading => _loading;
  late List<DeviceGroupModel> listGroup;
  late List<DeviceStageModel> _lDeviceStage;
  List<DeviceStageModel> get lDeviceStage => _lDeviceStage;
  DeviceStageModel? _deviceStage;
  DeviceStageModel? get deviceStage => _deviceStage;
  DeviceStageModel? _dvReportCurrent;
  DeviceStageModel? get dvReportCurrent => _dvReportCurrent;
  late int _currentGroupID;
  int currentGroupIndex = 0;
  int timeIntervalCurrent = 20;
  int timeInterval = 60;
  bool _isSearch = false;
  bool get isSearch => _isSearch;
  List<String> _searchTerms = [];
  List<String> get searchTerms => _searchTerms;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    debugPrint('onClose');
    intervalDispose();
    super.onClose();
  }

  Future<void> getGroupDevice() async {
    _loading = true;
    intervalDispose();
    try {
      await DeviceAPI.getDeviceGroup().then((res) async {
        listGroup = List<DeviceGroupModel>.from(
            res.map((e) => DeviceGroupModel.fromJson(e)).toList());
        _currentGroupID = listGroup[currentGroupIndex].vehicleGroupID;
        await DeviceAPI.getListDevieStage(_currentGroupID).then((res) {
          var listDState = List<DeviceStageModel>.from(
              res.map((e) => DeviceStageModel.fromJson(e)).toList());
          listGroup[currentGroupIndex].listDvStage = listDState;
          _lDeviceStage = listDState;
        });
      });

      intervalCurrentData();
      interval();
    } catch (e) {
      debugPrint(e.toString());
    }
    _loading = false;
    update();
  }

  Future<void> getListDVStage() async {
    // _loading = true;
    await DeviceAPI.getListDevieStage(_currentGroupID).then((res) async {
      var listDState = List<DeviceStageModel>.from(
          res.map((e) => DeviceStageModel.fromJson(e)).toList());

      listGroup[currentGroupIndex].listDvStage = listDState;
    });
    // _loading = false;
    update();
  }

  void setDvInfo(deviceId) async {
    _loading = true;
    await DeviceAPI.getDevieStageById(_deviceStage!.deviceID, true)
        .then((res) async {
      _deviceStage!.deviceInfo = DeviceInfoModel.fromJson(res);
    });
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

  void setDeviceReport(int deviceId) {
    _dvReportCurrent = listGroup[currentGroupIndex]
        .listDvStage!
        .where((element) => element.deviceID == deviceId)
        .first;
    update();
  }

  void changeCurrentGroupByIndex(value) {
    currentGroupIndex = value;
    _currentGroupID = listGroup[currentGroupIndex].vehicleGroupID;
    update();
  }

  void changeCurrentGroupById(value) {
    _currentGroupID = value;
    currentGroupIndex =
        listGroup.indexWhere((element) => element.vehicleGroupID == value);
    update();
  }

  void setDeviceState(value) {
    _deviceStage = value;
    update();
  }

  // ------------- INTERVAL -----------
  void intervalCurrentData() {
    _intervalCurrentData =
        Timer.periodic(Duration(seconds: timeIntervalCurrent), (timer) async {
      await DeviceAPI.getListDevieStage(_currentGroupID).then((res) async {
        debugPrint('intervalCurrentData');
        var listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());

        listGroup[currentGroupIndex].listDvStage = listDState;
        _lDeviceStage = listDState;
        update();
      });
    });
  }

  void interval() {
    if (listGroup.length > 1) {
      _interval =
          Timer.periodic(Duration(seconds: timeInterval), (timer) async {
        for (int i = 0; i < listGroup.length; i++) {
          if (i != currentGroupIndex) {
            await DeviceAPI.getListDevieStage(listGroup[i].vehicleGroupID)
                .then((res) async {
              var listDState = List<DeviceStageModel>.from(
                  res.map((e) => DeviceStageModel.fromJson(e)).toList());

              listGroup[i].listDvStage = listDState;
              update();
            });
          }
        }
      });
    }
  }

  void intervalDispose() {
    if (_intervalCurrentData != null) {
      _intervalCurrentData!.cancel();
    }
    if (_interval != null) {
      _interval!.cancel();
    }
  }

  // SEARCH
  void openSearch() {
    _isSearch = true;
    update();
  }

  void closeSearch() {
    _isSearch = false;
    update();
  }
}
