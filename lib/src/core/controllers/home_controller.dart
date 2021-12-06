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

  double _panelPosition = -120;
  double get panelPosition => _panelPosition;

  final position = MFCameraPosition(
      bearing: 2.0, target: MFLatLng(10.7553411, 106.4150405), zoom: 6);
  late MFMapView _map;
  MFMapView get map => _map;

  late MFMapViewController _controller;

  late List<DeviceGroupModel> listDGroup;
  late List<DeviceStageModel> listDState;
  late DeviceStageModel? _dvStageCurent;
  DeviceStageModel? get dvStageCurent => _dvStageCurent;

  Set<MFMarker> markers = Set();

  @override
  void onInit() {
    super.onInit();
    _map = MFMapView(
      initialCameraPosition: position,
      onMapCreated: onMapCreated,
      onCameraMoveStarted: onCameraMoveStarted,
      onCameraMove: onCameraMove,
      onCameraIdle: onCameraIdle,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onTap: onTap,
      markers: markers,
    );
    getDeviceGroup();
  }

  @override
  void onClose() {
    _intervalData.cancel();
  }

  void getDeviceGroup() async {
    _loading = true;
    try {
      await HomeAPI.getDeviceGroup().then((res) {
        listDGroup = List<DeviceGroupModel>.from(
            res.map((e) => DeviceGroupModel.fromJson(e)).toList());
      });
      await HomeAPI.getListDevieStage(listDGroup[0].vehicleGroupID).then((res) {
        listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());
      });

      _dvStageCurent = listDState[0];
      for (var item in listDState) {
        MFMarker resultMarker = MFMarker(
            consumeTapEvents: true,
            markerId: MFMarkerId(item.deviceID.toString()),
            position: MFLatLng(item.latitude, item.longitude),
            icon: await MFBitmap.fromAssetImage(
                const ImageConfiguration(), 'assets/icons/car_default.png'),
            onTap: () {
              moveCamera(item.latitude, item.longitude);
              panelMap(item);
            });
        markers.add(resultMarker);
      }
      interval(0);
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

  void setMap(int indexGroup) async {
    _loading = true;
    try {} catch (error) {
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

  void interval(int indexGroup) {
    _intervalData = Timer.periodic(Duration(seconds: 20), (timer) async {
      await HomeAPI.getListDevieStage(listDGroup[indexGroup].vehicleGroupID)
          .then((res) async {
        listDState = List<DeviceStageModel>.from(
            res.map((e) => DeviceStageModel.fromJson(e)).toList());
        debugPrint('data');
        markers.clear();
        for (var item in listDState) {
          MFMarker resultMarker = MFMarker(
              consumeTapEvents: true,
              markerId: MFMarkerId(item.deviceID.toString()),
              position: MFLatLng(item.latitude, item.longitude),
              icon: await MFBitmap.fromAssetImage(
                  const ImageConfiguration(), 'assets/icons/car_default.png'),
              onTap: () {
                moveCamera(item.latitude, item.longitude);
                panelMap(item);
              });
          markers.add(resultMarker);
        }
      });
    });
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
