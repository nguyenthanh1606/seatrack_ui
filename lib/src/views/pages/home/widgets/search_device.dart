import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/controllers/device_controller.dart';
import 'package:seatrack_ui/src/models/device_model.dart';

class SearchDevice extends StatelessWidget {
  const SearchDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
        init: Get.find<DeviceController>(),
        builder: (controller) => AnimatedOpacity(
              // If the widget is visible, animate to 0.0 (invisible).
              // If the widget is hidden, animate to 1.0 (fully visible).
              opacity: controller.isSearch ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              // The green box must be a child of the AnimatedOpacity widget.
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                padding: EdgeInsets.only(top: 100),
                child: controller.searchDv == null
                    ? Center(child: Text('Không tìm thấy xe!'))
                    : Column(
                        children: controller.searchDv!
                            .map<ListTile>((DeviceLessModel dv) {
                          return ListTile(
                            leading: Icon(Icons.car_rental),
                            title: Text(dv.vehicleNumber),
                            onTap: () {
                              controller.setCurentDv(dv.deviceID);
                            },
                          );
                        }).toList(),
                      ),
              ),
            ));
  }
}