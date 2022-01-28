import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/google_maps_utils.dart';
import 'package:seatrack_ui/src/helper/default.dart';

import 'device_controller.dart';

class DemoController extends GetxController {
  final deviceController = Get.find<DeviceController>();

  double zoomCurrent = 14.0;
  List<Marker> currentMarkers = [];
  late GoogleMapController _controller;
  bool _loading = false;
  bool get loading => _loading;
  List<BitmapDescriptor> markerIcon = [];
  late GoogleMap _map;
  GoogleMap get map => _map;
  @override
  void onInit() {
    super.onInit();
    setCustomMapPin();
  }

  void mapCreated(controller) {
    _controller = controller;
    // getJsonFile('assets/files/map_style.json').then(setMapStyle);
    update();
  }

  void setMap() {
    var value = deviceController.deviceStage;

    _map = GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(value!.latitude, value.longitude), zoom: 18.0),
      markers: Set.from(currentMarkers),
      onMapCreated: mapCreated,
      onCameraMove: onGeoChanged,
    );
  }

  void onGeoChanged(CameraPosition position) {
    zoomCurrent = position.zoom;
    update();
  }

  void setCustomMapPin() async {
    _loading = true;
    await setIconMarker();
    var value = deviceController.deviceStage;
    Point from = Point(value!.latitude_last!, value.longitude_last!);
    Point to = Point(value.latitude, value.longitude);
    double angle = SphericalUtils.computeHeading(from, to);
    currentMarkers.add(
      Marker(
          markerId: MarkerId(value.deviceID.toString()),
          draggable: false,
          icon: markerIcon[value.state],
          infoWindow: InfoWindow(title: value.vehicleNumber),
          position: LatLng(value.latitude, value.longitude),
          rotation: angle,
          onTap: () {}),
    );
    setMap();
    interval();
    _loading = false;
    update();
  }

  Future<void> setIconMarker() async {
    for (var item in CAR_MARKER) {
      await getBytesFromAsset(item["mapIcon"]!, 35).then((onValue) {
        markerIcon.add(BitmapDescriptor.fromBytes(onValue));
      });
    }
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

  void interval() {}
}
