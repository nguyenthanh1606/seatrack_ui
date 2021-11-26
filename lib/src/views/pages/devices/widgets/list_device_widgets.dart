import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/helper/ulti.dart';
import 'package:seatrack_ui/src/views/pages/report/report_history_page.dart';
import 'package:seatrack_ui/src/views/themes/_themes.dart';

import '../info_device_page.dart';

class ListDeviceWidget extends StatefulWidget {
  const ListDeviceWidget({Key? key, this.devices}) : super(key: key);
  final devices;

  @override
  _ListDeviceWidgetState createState() => _ListDeviceWidgetState();
}

class _ListDeviceWidgetState extends State<ListDeviceWidget> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        itemCount: widget.devices.length,
        padding: const EdgeInsets.only(top: 10.0),
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 30,
                            child: Icon(Icons.local_taxi,
                                size: 40,
                                color:
                                    statusColor(widget.devices[index].status)),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                right: 10,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                                  decoration: BoxDecoration(
                                    color: statusColor(
                                        widget.devices[index].status),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        child: Text(
                                          statusString(
                                                  widget.devices[index].status)
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          widget.devices[index].status == 1
                                              ? '${widget.devices[index].speed.toString()} Km/h'
                                              : timeDevice(widget
                                                  .devices[index].dateSave),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 5, 0),
                                          child: Container(
                                            width: 7,
                                            height: 7,
                                            decoration: BoxDecoration(
                                              color: statusColor(
                                                  widget.devices[index].status),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          child: Text(
                                            widget.devices[index].verticalNumber
                                                .toString(),
                                            style: TextStyle(
                                                color: statusColor(widget
                                                    .devices[index].status),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      child: Text(
                                        'IMEI: ${widget.devices[index].imei}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: AppWidthHeight.w500,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        'Địa chỉ: ${widget.devices[index].address}',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: ListViewCategories(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pullRefresh() async {
    print('reload');
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }
}

class ListViewCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Positioned(
        //   top: 0,
        //   bottom: 0,
        //   right: 0,
        //   child: Icon(Icons.more_vert, color: Theme.of(context).primaryColor),
        // ),
        Padding(
          // padding: const EdgeInsets.only(right: 30),
          padding: const EdgeInsets.only(right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                label: Text(
                  'Thông tin',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                icon: Icon(Icons.description),
                onPressed: () {
                  Get.to(() => DeviceInfoPage());
                },
              ),
              TextButton.icon(
                label: Text(
                  'Vị trí',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                icon: Icon(Icons.map_outlined),
                onPressed: () {},
              ),
              TextButton.icon(
                label: Text(
                  'Xem lại',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                icon: Icon(Icons.add_road),
                onPressed: () {
                  Get.to(() => ReportPage());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
