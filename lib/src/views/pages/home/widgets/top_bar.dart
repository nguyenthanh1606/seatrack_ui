import 'package:flutter/material.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      right: 0,
      top: 40,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 50.0,
                  width: (double.infinity / 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        hintText: "Nhập biển số cần tìm?",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                          iconSize: 30.0,
                        )),
                    onChanged: (val) {},
                    onSubmitted: (term) {},
                  ),
                ),
              ),
              // IconButton(
              //   color: Theme.of(context).primaryColor,
              //   icon: const Icon(Icons.group),
              //   onPressed: () {
              //     Scaffold.of(context).openDrawer();
              //   },
              // ),
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ],
          ),
          // Container(
          //   height: 100,
          //   color: Colors.white,
          //   margin: EdgeInsets.only(top: 2, right: 10),
          // ),
        ],
      ),
    );
  }
}
