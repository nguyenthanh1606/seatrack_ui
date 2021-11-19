import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceEditInfo extends StatelessWidget {
  const DeviceEditInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        title: Center(
          child: Text('Sửa thiết bị'),
        ),
      ),
      body: Container(
        child: Center(
          child: Text('Sửa thiết bị'),
        ),
      ),
    );
  }
}
