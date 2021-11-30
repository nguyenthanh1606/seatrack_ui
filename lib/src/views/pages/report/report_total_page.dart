import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/views/pages/report/widgets/tab_search_widget.dart';

import '../control_page.dart';
import 'widgets/end_draw_widget.dart';
import 'widgets/menu_widget.dart';

class ReportTotalPage extends StatefulWidget {
  const ReportTotalPage({Key? key}) : super(key: key);

  @override
  _ReportTotalPageState createState() => _ReportTotalPageState();
}

class _ReportTotalPageState extends State<ReportTotalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: EndDrawReport(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {Get.to(() => ControlPage())},
        ),
        title: Text('Báo cáo tổng hợp'),
        centerTitle: true,
        actions: [
          PopUpMenuWidget(),
        ],
      ),
      body: Stack(children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: TabSearchWidget(),
        )
      ]),
    );
  }
}
