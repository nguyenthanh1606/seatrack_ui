import 'package:flutter/material.dart';

class EndDrawReport extends StatefulWidget {
  const EndDrawReport({Key? key}) : super(key: key);

  @override
  _EndDrawReportState createState() => _EndDrawReportState();
}

class _EndDrawReportState extends State<EndDrawReport> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          height: MediaQuery.of(context).size.height * 5 / 7,
          left: 0,
          right: 0,
          bottom: 0,
          child: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          hintText: "Nhập biển số cần tìm?",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 15.0, top: 15.0),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                            iconSize: 30.0,
                          )),
                      onChanged: (val) {
                        setState(() {});
                      },
                      onSubmitted: (term) {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('data'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
