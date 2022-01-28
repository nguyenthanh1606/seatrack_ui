import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/controllers/device_controller.dart';
import 'package:seatrack_ui/src/helper/ulti.dart';
import 'package:seatrack_ui/src/models/device_model.dart';

import 'widgets/list_device_widgets.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DevicePageState();
  }
}

class DevicePageState extends State<DevicePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: "Tất cả"),
    Tab(text: "Đang chạy"),
    Tab(text: "Dừng"),
    Tab(text: "Mất liên lạc"),
    Tab(text: "Khác"),
  ];
  TabController? _tabController;
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    searchController.dispose();
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DeviceController>(
        init: Get.find<DeviceController>(),
        builder: (controller) => NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: controller.isSearch
                    ? IconButton(
                        onPressed: () {
                          controller.closeSearch();
                        },
                        icon: const Icon(Icons.close))
                    : IconButton(
                        onPressed: () {
                          controller.openSearch();
                          showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(),
                          );
                        },
                        icon: const Icon(Icons.search),
                      ),
                actions: <Widget>[
                  PopupMenuButton(
                    itemBuilder: (context) => controller.listGroup
                        .map(
                          (e) => PopupMenuItem(
                            child: Text("${e.vehicleGroup} (${e.countdv})"),
                            value: controller.listGroup.indexOf(e),
                            onTap: () {
                              controller.closeSearch();

                              controller
                                  .changeCurrentGroupById(e.vehicleGroupID);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
                title: Text('Danh sách xe'.toUpperCase()),
                centerTitle: true,
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
          body: controller.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(
                  controller: _tabController,
                  children: tabs.map((Tab tab) {
                    var index = tabs.indexOf(tab);
                    List<DeviceStageModel> listDevices = [];
                    List<DeviceStageModel> devices = [];

                    if (controller.isSearch) {
                      List<DeviceStageModel> temp = [];
                      if (controller.deviceStage != null) {
                        temp.add(controller.deviceStage!);
                      }
                      listDevices = temp;
                    } else {
                      listDevices = controller
                          .listGroup[controller.currentGroupIndex].listDvStage!;
                    }
                    switch (index) {
                      case 0:
                        devices = listDevices;
                        break;
                      case 1:
                        devices = listDevices
                            .where((element) => element.state == 3)
                            .toList();
                        break;
                      case 2:
                        devices = listDevices
                            .where((element) => element.state == 4)
                            .toList();
                        break;
                      case 3:
                        devices = listDevices
                            .where((element) => element.state == 2)
                            .toList();
                        break;
                      case 4:
                        devices = listDevices
                            .where((element) =>
                                element.state == 1 ||
                                element.state == 5 ||
                                element.state == 6)
                            .toList();
                        break;
                      default:
                    }
                    return ListDeviceWidget(index: index, devices: devices);
                    // return Column(
                    //     children: controller
                    //         .listDGroup[controller.currentIndexGroup]
                    //         .listDvStage!
                    //         .map((item) => Text(item.vehicleNumber))
                    //         .toList());
                  }).toList(),
                ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = Get.find<DeviceController>().searchTerms;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Get.find<DeviceController>().closeSearch();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    debugPrint('buildResults');
    List<DeviceStageModel> matchQuery = [];
    List<DeviceGroupModel> listDGroup = Get.find<DeviceController>().listGroup;
    for (var item in listDGroup) {
      if (item.listDvStage != null) {
        for (var item2 in item.listDvStage!) {
          if (item2.vehicleNumber.toLowerCase().contains(query.toLowerCase())) {
            matchQuery.add(item2);
          }
        }
      }
    }
    if (matchQuery.length == 0)
      return Container(
          child: Center(child: Text('Không tìm thấy thông tin xe...')));

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return Card(
            child: InkWell(
              onTap: () {
                Get.find<DeviceController>().setDeviceState(result);
                close(context, null);
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(
                        child: Icon(Icons.directions_car, color: Colors.white),
                        backgroundColor: statusColor(result.state)),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: 2,
                      color: statusColor(result.state),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      result.vehicleNumber,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: statusColor(result.state)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    debugPrint('buildSuggestions');
    List<DeviceStageModel> matchQuery = [];
    List<DeviceGroupModel> listDGroup = Get.find<DeviceController>().listGroup;
    for (var item in listDGroup) {
      if (item.listDvStage != null) {
        for (var item2 in item.listDvStage!) {
          if (item2.vehicleNumber.toLowerCase().contains(query.toLowerCase())) {
            matchQuery.add(item2);
          }
        }
      }
    }
    if (matchQuery.length == 0) {
      return Center(child: Text('Không tìm thấy thông tin xe...'));
    } else {
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return Card(
            child: InkWell(
              onTap: () {
                Get.find<DeviceController>().setDeviceState(result);
                close(context, null);
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(
                        child: Icon(Icons.directions_car, color: Colors.white),
                        backgroundColor: statusColor(result.state)),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: 2,
                      color: statusColor(result.state),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      result.vehicleNumber,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: statusColor(result.state)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
