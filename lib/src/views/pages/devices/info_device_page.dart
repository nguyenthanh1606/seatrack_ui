import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/helper/ulti.dart';
import 'package:seatrack_ui/src/models/device_model.dart';
import 'package:seatrack_ui/src/views/widgets/_widgets.dart';

class DeviceInfoPage extends StatelessWidget {
  const DeviceInfoPage({Key? key, required this.device}) : super(key: key);
  final DeviceStageModel device;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {Get.back()},
          ),
          title: Text(device.vehicleNumber),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.drive_file_rename_outline), onPressed: () {},
              // onPressed: () {
              //   Get.to(() => DeviceEditInfo());
              // },
            ),
          ]),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTileItemWidget(
                      Icons.album, 'Tên thiết bị', device.vehicleNumber),
                  ListTileItemWidget(
                      Icons.album, 'Loại thiết bị', device.deviceInfo!.version),
                  ListTileItemWidget(
                      Icons.album, 'IMEI', device.deviceInfo!.imei),
                  ListTileItemWidget(
                      Icons.album, 'SIM', device.deviceInfo!.simNumberInf),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTileItemWidget(Icons.album, 'Tình trạng', '#'),
                  ListTileItemWidget(Icons.album, 'ACC', '#'),
                  ListTileItemWidget(Icons.album, 'Thời gian cập nhật',
                      changeDateTime(device.dateSave)),
                  ListTileItemWidget(
                      Icons.album, 'Tốc độ', '${device.speed.toString()} km/h'),
                  ListTileItemWidget(
                      Icons.album, 'Vĩ độ', device.latitude.toString()),
                  ListTileItemWidget(
                      Icons.album, 'Kinh độ', device.longitude.toString()),
                  ListTileItemWidget(Icons.album, 'Địa chỉ', '#'),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTileItemWidget(Icons.album, 'Hết hạn',
                      changeDateTime(device.deviceInfo!.dateExpired)),
                  ListTileItemWidget(
                      Icons.album, 'Biển số xe', device.vehicleNumber),
                  ListTileItemWidget(
                      Icons.album, 'Tên lái xe', device.theDriver),
                  ListTileItemWidget(Icons.album, 'Số liên lạc', '#'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
