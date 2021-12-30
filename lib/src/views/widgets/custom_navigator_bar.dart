import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/controllers/page_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GetBuilder<ControlViewModel>(
        builder: (controller) => ConvexAppBar(
          backgroundColor: const Color(0xFF009688),
          initialActiveIndex: controller.navigatorIndex,
          onTap: (index) {
            controller.changeCurrentScreen(index);
          },
          items: const [
            TabItem(icon: Icons.notifications, title: 'Thông báo'),
            TabItem(icon: Icons.article, title: 'Báo cáo'),
            TabItem(icon: Icons.map, title: 'Giám sát'),
            TabItem(icon: Icons.people, title: 'Cá nhân'),
            TabItem(icon: Icons.more_horiz, title: 'Menu'),
          ],
        ),
      ),
    );
  }
}
