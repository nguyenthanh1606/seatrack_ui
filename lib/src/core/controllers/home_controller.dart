import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:map4d_map/map4d_map.dart';
import 'package:seatrack_ui/src/core/repositories/home_api.dart';
import 'package:seatrack_ui/src/models/device_model.dart';

class HomeController extends GetxController {
  late Timer _intervalData;
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
    _intervalData.cancel();
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
      await HomeAPI.getDeviceGroup().then((res) {
        listDGroup = List<DeviceGroupModel>.from(
            res.map((e) => DeviceGroupModel.fromJson(e)).toList());
      });
      _currentGroupID = listDGroup[_currentIndexGroup].vehicleGroupID;
      await HomeAPI.getListDevieStage(_currentGroupID).then((res) {
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
      await HomeAPI.getListDevieStage(_currentGroupID).then((res) {
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
      await HomeAPI.getListDevieStage(_currentGroupID).then((res) async {
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
          }
        }
      });
    });
    update();
  }

  void changeCurrentGroup(int vehicleGroupID) {
    debugPrint('changeCurrentGroup');
    _currentIndexGroup = listDGroup
        .indexWhere((element) => element.vehicleGroupID == vehicleGroupID);
    _currentGroupID = vehicleGroupID;
    markers.clear();
    setMap();
    update();
  }

  Future<void> toggle(int index) async {
    _loading = true;
    listDGroup[index].isShow = !listDGroup[index].isShow;
    if (listDGroup[index].listDvStage == null) {
      await HomeAPI.getListDevieStage(listDGroup[index].vehicleGroupID)
          .then((res) async {
        var listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());

        listDGroup[index].listDvStage = listDState;
      });
    }
    _loading = false;
    update();
  }

  void setCurentDv(DeviceStageModel dv) {
    _dvStageCurent = dv;
    markers.clear();
    // setmap
    // setMapCurrent(dv);
    // // init map
    initMap;
    debugPrint('');

    update();
  }

  Future<void> setMapCurrent(DeviceStageModel dv) async {
    final MFMarkerId markerId = MFMarkerId(dv.deviceID.toString());
    MFMarker marker = MFMarker(
        consumeTapEvents: true,
        markerId: markerId,
        position: MFLatLng(dv.latitude, dv.longitude),
        icon: await MFBitmap.fromAssetImage(
            const ImageConfiguration(), 'assets/icons/car_blue.png'),
        onTap: () {
          moveCamera(dv.latitude, dv.longitude);
          panelMap(dv);
        });
    markers[markerId] = marker;
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
