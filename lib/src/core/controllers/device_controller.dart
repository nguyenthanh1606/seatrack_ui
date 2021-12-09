import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:map4d_map/map4d_map.dart';
import 'package:seatrack_ui/src/core/repositories/home_api.dart';
import 'package:seatrack_ui/src/models/device_model.dart';

class DeviceController extends GetxController {
  Timer? _intervalData, _intervalCurrentData;
  bool _loading = false;
  bool get loading => _loading;
  late int _currentGroupID;
  int _currentIndexGroup = 0;
  int get currentGroupID => _currentGroupID;
  int get currentIndexGroup => _currentIndexGroup;

  double _panelPosition = -120;
  double get panelPosition => _panelPosition;

  final position = MFCameraPosition(
      bearing: 2.0, target: MFLatLng(10.7553411, 106.4150405), zoom: 6);
  late MFMapView _map;
  MFMapView get map => _map;

  late MFMapViewController _controller;

  late List<DeviceGroupModel> listDGroup;
  // late List<DeviceStageModel> listDState;
  late DeviceStageModel? _dvStageCurent;
  DeviceStageModel? get dvStageCurent => _dvStageCurent;

  Map<MFMarkerId, MFMarker> markers = <MFMarkerId, MFMarker>{};

  @override
  void onInit() {
    super.onInit();
    initMap();
    getDeviceGroup();
  }

  @override
  void onClose() {
    intervalCancel();
  }

  void initMap() {
    _map = MFMapView(
      initialCameraPosition: position,
      mapType: MFMapType.roadmap,
      onMapCreated: onMapCreated,
      onCameraMoveStarted: onCameraMoveStarted,
      onCameraMove: onCameraMove,
      onCameraIdle: onCameraIdle,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onTap: onTap,
      markers: Set<MFMarker>.of(markers.values),
    );
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
      _dvStageCurent = listDGroup[_currentIndexGroup].listDvStage![0];
      if (listDGroup[_currentIndexGroup].listDvStage != null) {
        for (var item in listDGroup[_currentIndexGroup].listDvStage!) {
          final MFMarkerId markerId = MFMarkerId(item.deviceID.toString());
          MFMarker marker = MFMarker(
              consumeTapEvents: true,
              markerId: markerId,
              position: MFLatLng(item.latitude, item.longitude),
              icon: await MFBitmap.fromAssetImage(
                  const ImageConfiguration(), 'assets/icons/car_blue.png'),
              onTap: () {
                moveCamera(item.latitude, item.longitude);
                panelMap(item);
              });
          markers[markerId] = marker;
        }
      }

      initMap();
      interval();
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

  void setMap() async {
    _loading = true;
    try {
      await DeviceAPI.getListDevieStage(_currentGroupID).then((res) {
        var listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());
        _dvStageCurent = listDState[0];
        listDGroup[_currentIndexGroup].listDvStage = listDState;
      });
      for (var item in listDGroup[_currentIndexGroup].listDvStage!) {
        final MFMarkerId markerId = MFMarkerId(item.deviceID.toString());
        MFMarker marker = MFMarker(
            consumeTapEvents: true,
            markerId: markerId,
            position: MFLatLng(item.latitude, item.longitude),
            icon: await MFBitmap.fromAssetImage(
                const ImageConfiguration(), 'assets/icons/car_blue.png'),
            onTap: () {
              moveCamera(item.latitude, item.longitude);
              panelMap(item);
            });
        markers[markerId] = marker;
      }
      initMap();
      interval();
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

  void interval() {
    _intervalData = Timer.periodic(Duration(seconds: 20), (timer) async {
      await DeviceAPI.getListDevieStage(_currentGroupID).then((res) async {
        var listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());

        listDGroup[_currentIndexGroup].listDvStage = listDState;
        for (var item in listDState) {
          if (item.state == 3) {
            debugPrint('update marker ${item.vehicleNumber}');
            MFMarkerId markerId = MFMarkerId(item.deviceID.toString());
            final MFMarker marker = markers[markerId]!;
            markers[markerId] = marker.copyWith(
              positionParam: MFLatLng(item.latitude, item.longitude),
            );
            // debugPrint('${markers[markerId]}');
          }
        }
      });
    });
    update();
  }

  void intervalCurrentData(int deviceID) {
    _intervalCurrentData = Timer.periodic(Duration(seconds: 20), (timer) async {
      await DeviceAPI.getDevieStageById(deviceID, true).then((res) async {
        var dCurrent = DeviceStageModel.fromJson(res);

        debugPrint('update marker ${dCurrent.vehicleNumber}');
        MFMarkerId markerId = MFMarkerId(deviceID.toString());
        _changePostion(
            markerId, MFLatLng(dCurrent.latitude, dCurrent.longitude));
        panelMap(dCurrent);
      });
      initMap();
    });
  }

  void _changePostion(MFMarkerId markerId, MFLatLng loc) {
    final MFMarker marker = markers[markerId]!;
    markers[markerId] = marker.copyWith(positionParam: loc);
    update();
  }

  void changeCurrentGroup(int vehicleGroupID) {
    _currentIndexGroup = listDGroup
        .indexWhere((element) => element.vehicleGroupID == vehicleGroupID);
    _currentGroupID = vehicleGroupID;
    markers.clear();
    intervalCancel();
    setMap();
    update();
  }

  Future<void> toggle(int index) async {
    _loading = true;
    listDGroup[index].isShow = !listDGroup[index].isShow;
    if (listDGroup[index].listDvStage == null) {
      await DeviceAPI.getListDevieStage(listDGroup[index].vehicleGroupID)
          .then((res) async {
        var listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());

        listDGroup[index].listDvStage = listDState;
      });
    }
    _loading = false;
    update();
  }

  Future<void> setCurentDv(DeviceStageModel dv) async {
    intervalCancel();
    _dvStageCurent = dv;
    markers.clear();
    // setmap
    await setMapCurrent(dv).then((res) {
      panelMap(dv);
      intervalCurrentData(dv.deviceID);
    });
    update();
  }

  Future<MFMarker> setMapCurrent(DeviceStageModel dv) async {
    final MFMarkerId markerId = MFMarkerId(dv.deviceID.toString());
    moveCamera(dv.latitude, dv.longitude);

    MFMarker marker = MFMarker(
        consumeTapEvents: true,
        markerId: markerId,
        position: MFLatLng(dv.latitude, dv.longitude),
        icon: await MFBitmap.fromAssetImage(
            const ImageConfiguration(), 'assets/icons/car_blue.png'),
        onTap: () {
          panelMap(dv);
        });
    return markers[markerId] = marker;
  }

  void intervalCancel() {
    debugPrint('--------intervalCancel--------');
    if (_intervalData != null) {
      _intervalData!.cancel();
    }
    if (_intervalCurrentData != null) {
      _intervalCurrentData!.cancel();
    }
  }
  /////////////////////////////////
  ///          4D MAP           //
  ///////////////////////////////

  void panelMap(DeviceStageModel data) {
    _panelPosition = 0;
    _dvStageCurent = data;
    update();
  }

  void onMapCreated(MFMapViewController controller) {
    _controller = controller;
  }

  void onCameraMoveStarted() {}

  void onCameraMove(MFCameraPosition position) {}

  void onCameraIdle() {
    // print('onCameraIdle');
  }

  void moveCamera(double lat, double lng) {
    // MFCameraPosition cameraPosition =
    //     MFCameraPosition(bearing: 2.0, target: MFLatLng(lat, lng), zoom: 16);
    // final cameraUpdate = MFCameraUpdate.newLatLngZoom(MFLatLng(lat, lng), 10.0);
    // final cameraUpdate = MFCameraUpdate.newCameraPosition(cameraPosition);
    final cameraUpdate = MFCameraUpdate.newLatLng(MFLatLng(lat, lng));
    _controller.moveCamera(cameraUpdate);
  }

  void onTap(MFLatLng coordinate) {
    _panelPosition = -120;
    update();
  }
}
