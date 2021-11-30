import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../report_driver_page.dart';
import '../report_history_page.dart';
import '../report_oil_page.dart';
import '../report_speed_page.dart';
import '../report_total_page.dart';

class PopUpMenuWidget extends StatelessWidget {
  const PopUpMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Get.to(() => ReportHistoryPage());
            },
            child: Row(
              children: [
                Icon(
                  Icons.report_gmailerrorred,
                ),
                Text(
                  "   Báo cáo lộ trình",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Get.to(() => ReportOilPage());
            },
            child: Row(
              children: [
                Icon(
                  Icons.report_gmailerrorred,
                ),
                Text(
                  "   Báo cáo nhiên liệu",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Get.to(() => ReportDriverPage());
            },
            child: Row(
              children: [
                Icon(
                  Icons.report_gmailerrorred,
                ),
                Text(
                  "   Báo cáo HĐ tài xế",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Get.to(() => ReportSpeedPage());
            },
            child: Row(
              children: [
                Icon(
                  Icons.report_gmailerrorred,
                ),
                Text(
                  "   Báo cáo vi phạm tốc độ",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: TextButton(
            onPressed: () {
              Get.to(() => ReportTotalPage());
            },
            child: Row(
              children: [
                Icon(
                  Icons.report_gmailerrorred,
                ),
                Text(
                  "   Báo cáo tổng hợp",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
