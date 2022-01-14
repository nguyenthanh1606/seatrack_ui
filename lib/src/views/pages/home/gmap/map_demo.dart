import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seatrack_ui/src/core/controllers/device_controller.dart';
import 'package:seatrack_ui/src/core/controllers/gmap_controller.dart';
import 'package:seatrack_ui/src/models/device_model.dart';

import 'coffee_model.dart';

class GMapPage extends StatefulWidget {
  const GMapPage({Key? key}) : super(key: key);

  @override
  _GMapPageState createState() => _GMapPageState();
}

class _GMapPageState extends State<GMapPage> {
  int prevPage = 0;
  // List<DeviceStageModel> listDvStage = Get.find<DeviceController>().lDeviceStage;

  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(initialPage: 0, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GMapController());

    return GetBuilder<GMapController>(
      init: Get.find<GMapController>(),
      builder: (controller) => controller.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    initialCameraPosition: controller.position,
                    markers: Set.from(controller.allMarkers),
                    onMapCreated: controller.mapCreated,
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  child: Container(
                    height: 150.0,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount:
                          Get.find<DeviceController>().lDeviceStage.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _deviceList(index);
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }

  void _onScroll() {
    if (_pageController.page!.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      Get.find<GMapController>().moveCamera(LatLng(
          Get.find<DeviceController>()
              .lDeviceStage[_pageController.page!.toInt()]
              .latitude,
          Get.find<DeviceController>()
              .lDeviceStage[_pageController.page!.toInt()]
              .longitude));
    }
  }

  _deviceList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: () {
          debugPrint(_pageController.page!.toString());
          _onScroll();
          // moveCamera();
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                height: 125.0,
                width: 275.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 10.0,
                      ),
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Wrap(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Get.find<DeviceController>()
                                    .lDeviceStage[index]
                                    .vehicleNumber,
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                Get.find<DeviceController>()
                                    .lDeviceStage[index]
                                    .dateSave
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                width: 170.0,
                                child: Text(
                                  Get.find<DeviceController>()
                                      .lDeviceStage[index]
                                      .stateStr,
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
