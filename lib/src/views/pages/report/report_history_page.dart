import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/views/pages/report/widgets/tab_search_widget.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../control_page.dart';
import 'widgets/end_draw_widget.dart';
import 'widgets/menu_widget.dart';

class ReportHistoryPage extends StatefulWidget {
  const ReportHistoryPage({Key? key}) : super(key: key);

  @override
  _ReportHistoryPageState createState() => _ReportHistoryPageState();
}

class _ReportHistoryPageState extends State<ReportHistoryPage> {
  late MapShapeSource _mapSource;
  MapTileLayerController? _mapController;
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _mapController = MapTileLayerController();
    _zoomPanBehavior = MapZoomPanBehavior(
      minZoomLevel: 3,
      zoomLevel: 10,
      focalLatLng: const MapLatLng(51.4700, -0.2843),
      toolbarSettings: const MapToolbarSettings(
          direction: Axis.vertical, position: MapToolbarPosition.bottomRight),
      maxZoomLevel: 15,
      enableDoubleTapZooming: true,
    );

    super.initState();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _mapController = null;
    super.dispose();
  }

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
        title: Text('Báo cáo lộ trình'),
        centerTitle: true,
        actions: [
          PopUpMenuWidget(),
        ],
      ),
      body: Stack(children: [
        SfMaps(
          layers: <MapLayer>[
            MapTileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              controller: _mapController,
              zoomPanBehavior: _zoomPanBehavior,
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: TabSearchWidget(),
        ),
      ]),
    );
  }
}
