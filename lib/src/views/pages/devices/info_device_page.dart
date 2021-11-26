import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/views/widgets/_widgets.dart';

import 'device_edit_info.dart';

class DeviceInfoPage extends StatelessWidget {
  const DeviceInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {Get.back()},
          ),
          title: Text('Thông tin thiết bị'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.drive_file_rename_outline),
              onPressed: () {
                Get.to(() => DeviceEditInfo());
              },
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
                children: const <Widget>[
                  ListTileItemWidget(Icons.album, 'Tên thiết bị', 'Audi Q7'),
                  ListTileItemWidget(Icons.album, 'Loại thiết bị', 'GP.01'),
                  ListTileItemWidget(Icons.album, 'IMEI', '86115522456244'),
                  ListTileItemWidget(Icons.album, 'SIM', '0123456789'),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  ListTileItemWidget(Icons.album, 'Tình trạng', 'Online'),
                  ListTileItemWidget(Icons.album, 'ACC', 'Mở'),
                  ListTileItemWidget(
                      Icons.album, 'Thời gian cập nhật', '2021-11-11 12:03:03'),
                  ListTileItemWidget(Icons.album, 'Tốc độ', '0 km/h'),
                  ListTileItemWidget(Icons.album, 'Vĩ độ', '08.11225'),
                  ListTileItemWidget(Icons.album, 'Kinh độ', '104.22445'),
                  ListTileItemWidget(Icons.album, 'Địa chỉ',
                      '184/1 Nguyễn Văn Khối, phường 9, quận Gò Vấp, tp Hồ Chí Minh, Việt Nam'),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  ListTileItemWidget(
                      Icons.album, 'Hết hạn', '2022-11-11 12:03:03'),
                  ListTileItemWidget(Icons.album, 'Biển số xe', '51F09-12111'),
                  ListTileItemWidget(Icons.album, 'Tên lái xe', ''),
                  ListTileItemWidget(Icons.album, 'Số liên lạc', '0123456789'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
