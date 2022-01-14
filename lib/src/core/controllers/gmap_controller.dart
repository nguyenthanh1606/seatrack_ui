import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/google_maps_utils.dart';

import 'device_controller.dart';

class GMapController extends GetxController {
  final deviceController = Get.find<DeviceController>();

  bool _loading = false;
  bool get loading => _loading;
  late BitmapDescriptor pinLocationIcon;

  Timer? _intervalMap;
  late GoogleMapController _controller;

  final position = const CameraPosition(
      bearing: 2.0, target: LatLng(10.7553411, 106.4150405), zoom: 6);
  List<Marker> allMarkers = [];

  @override
  void onInit() {
    super.onInit();
    setCustomMapPin();
  }

  @override
  void onClose() {
    intervalDispose();
    super.onClose();
  }

  void setCustomMapPin() async {
    _loading = true;

    await deviceController.getGroupDevice();
    await getBytesFromAsset('assets/icons/car-top.png', 40).then((onValue) {
      pinLocationIcon = BitmapDescriptor.fromBytes(onValue);
    });
    if (deviceController
            .listGroup[deviceController.currentGroupIndex].listDvStage ==
        null) {
      await Future.delayed(Duration(seconds: 2));
    }
    deviceController.listGroup[deviceController.currentGroupIndex].listDvStage!
        .forEach(
      (element) {
        allMarkers.add(
          Marker(
              markerId: MarkerId(element.deviceID.toString()),
              draggable: false,
              icon: pinLocationIcon,
              infoWindow: InfoWindow(title: element.vehicleNumber),
              position: LatLng(element.latitude, element.longitude),
              onTap: () {
                moveCamera(LatLng(element.latitude, element.longitude));
              }),
        );
      },
    );
    interval();
    _loading = false;
    update();
  }

  void mapCreated(controller) {
    _controller = controller;
    getJsonFile('assets/files/map_style.json').then(setMapStyle);
    update();
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyles) {
    _controller.setMapStyle(mapStyles);
  }

  moveCamera(LatLng target) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: 15.0, bearing: 45.0)));
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

//--------------INTERVAL----------------
  void interval() {
    _intervalMap = Timer.periodic(Duration(seconds: 20), (timer) async {
      for (var item in deviceController.lDeviceStage) {
        if (item.state == 3) {
          MarkerId markerId = MarkerId(item.deviceID.toString());

          int index = allMarkers
              .toList()
              .indexWhere((item) => item.markerId == markerId);

          Point from = Point(allMarkers[index].position.latitude,
              allMarkers[index].position.longitude);
          Point to = Point(item.latitude, item.longitude);
          double angle = SphericalUtils.computeHeading(from, to);
          Marker _marker = Marker(
              markerId: MarkerId(item.deviceID.toString()),
              draggable: false,
              icon: pinLocationIcon,
              rotation: angle,
              infoWindow: InfoWindow(title: item.vehicleNumber),
              position: LatLng(item.latitude, item.longitude),
              onTap: () {
                moveCamera(LatLng(item.latitude, item.longitude));
              });

          allMarkers[index] = _marker;
          // debugPrint('${markers[markerId]}');
        }
      }
      // if (_dvStageCurent != null) {
      //   moveCamera(_dvStageCurent!.latitude, _dvStageCurent!.longitude);
      // }

      update();
    });
  }

  void intervalDispose() {
    if (_intervalMap != null) {
      _intervalMap!.cancel();
    }
  }
}
