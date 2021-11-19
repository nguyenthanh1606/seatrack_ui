import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          title: Center(
            child: Text('Thông tin thiết bị'),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.drive_file_rename_outline),
              onPressed: () {
                Get.to(() => DeviceEditInfo());
              },
            ),
          ]),
      body: Container(
        child: Center(
          child: Text('Thông tin thiết bị'),
        ),
      ),
    );
  }
}
