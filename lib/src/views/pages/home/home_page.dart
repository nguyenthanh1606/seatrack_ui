import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/controllers/app_system_controller.dart';
import 'package:seatrack_ui/src/core/services/local_storage_map.dart';

import 'gmap/map_main_page.dart';
import '4dmap/4dmap_main_page.dart';
import 'omap/omap_main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget? page = GMapPage();

  Future<void> getPage() async {
    String mName = await getMap();
    switch (mName) {
      case 'Map4D':
        page = DMapPage();
        break;
      case 'OpenStreetMap':
        page = OMapPage();
        break;
      case 'GoogleMap':
        page = GMapPage();
        break;
      default:
        page = OMapPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: getPage(),
        builder: (context, snapshot) {
          return page!;
        });
  }
}
