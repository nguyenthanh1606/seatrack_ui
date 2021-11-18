import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/controllers/_controller.dart';
import 'package:seatrack_ui/src/helper/path.dart';
import 'package:seatrack_ui/src/helper/ulti.dart';
import 'package:seatrack_ui/src/views/themes/_themes.dart';
import 'package:seatrack_ui/src/views/widgets/_widgets.dart';

class ListDeviceWidget extends StatefulWidget {
  const ListDeviceWidget({Key? key, this.devices, this.index})
      : super(key: key);
  final devices;
  final index;

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
      child: ListView.builder(
        itemCount: widget.devices.length,
        padding: const EdgeInsets.only(top: 10.0),
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 30,
                        child: Icon(Icons.local_taxi,
                            size: 50,
                            color: statusColor(widget.devices[index].status)),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            right: 10,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                              decoration: BoxDecoration(
                                color:
                                    statusColor(widget.devices[index].status),
                              ),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    child: Text(
                                      statusString(widget.devices[index].status)
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      widget.devices[index].status == 1
                                          ? '${widget.devices[index].speed.toString()} Km/h'
                                          : timeDevice(
                                              widget.devices[index].dateSave),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 5, 0),
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
                                          color: statusColor(
                                              widget.devices[index].status),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppWidthHeight.w500,
                              ),
                              // RichText(
                              //   text: TextSpan(
                              //     style: TextStyle(color: Colors.black),
                              //     children: [
                              //       WidgetSpan(
                              //         child:
                              //             Icon(Icons.vpn_key_sharp, size: 14),
                              //       ),
                              //       TextSpan(
                              //         text: " mở",
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: AppWidthHeight.w250,
                              // ),
                              // RichText(
                              //   text: TextSpan(
                              //     style: TextStyle(color: Colors.black),
                              //     children: [
                              //       WidgetSpan(
                              //         child: Icon(Icons.signal_cellular_alt,
                              //             size: 14),
                              //       ),
                              //       TextSpan(
                              //         text: " Tốt",
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: AppWidthHeight.w250,
                              // ),
                              SizedBox(
                                child: Text(
                                    '${widget.devices[index].lat.toString()},${widget.devices[index].lng.toString()}'),
                              ),
                              SizedBox(
                                height: AppWidthHeight.w250,
                              ),
                              SizedBox(
                                child: Text(widget.devices[index].address),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 1,
                  endIndent: 1,
                ),
                SizedBox(
                  height: 10.h,
                ),
                ListViewCategories(),
              ],
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
    return Container(
      height: 68.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return GestureDetector(
            // onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(50.r),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: Colors.white,
                    ),
                    height: 45.h,
                    width: 45.w,
                    child: Padding(
                      padding: EdgeInsets.all(14.h),
                      child: Image(
                        image: AssetImage(pathIcon('ignition.png')),
                      ),
                    ),
                  ),
                ),
                const CustomText(
                  text: 'Category',
                  fontSize: 12,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 16.w,
          );
        },
      ),
    );
  }
}
