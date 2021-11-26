import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/views/pages/report/widgets/tab_search_widget.dart';

import 'widgets/end_draw_widget.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: EndDrawReport(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        title: Text('Tra cứu lộ trình'),
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

class PopUpMenuWidget extends StatelessWidget {
  const PopUpMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Icons.report_gmailerrorred,
                ),
                Text(
                  "   Báo cáo dầu",
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
