import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/models/mock/device_stage_mock.dart';
import 'package:seatrack_ui/src/views/themes/_themes.dart';

import 'widgets/list_device_widgets.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeWidgetState();
  }
}

class HomeWidgetState extends State<ExamplePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: "Tất cả"),
    Tab(text: "Đang chạy"),
    Tab(text: "Dừng"),
    Tab(text: "Mất liên lạc"),
  ];
  final List<DeviceStageMock> devices = getDeviceStageMock();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.search),
                onPressed: () => {},
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => {},
                ),
              ],
              title: Center(child: Text('Danh sách xe'.toUpperCase())),
              pinned: true, //<-- pinned to true
              floating: true, //<-- floating to true
              forceElevated:
                  innerBoxIsScrolled, //<-- forceElevated to innerBoxIsScrolled
              bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white,
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: const BubbleTabIndicator(
                  indicatorHeight: 25.0,
                  indicatorColor: Colors.cyan,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                ),
                tabs: tabs,
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((Tab tab) {
            return ListDeviceWidget(devices: devices);
          }).toList(),
        ),
      ),
    );
  }
}
