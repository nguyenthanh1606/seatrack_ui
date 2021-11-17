import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/controllers/_controller.dart';
import 'package:seatrack_ui/src/core/controllers/page_controller.dart';
import 'package:seatrack_ui/src/views/pages/auth/auth_page.dart';
import 'package:seatrack_ui/src/views/widgets/_widgets.dart';

class ControlPage extends StatelessWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Get.find<AuthController>().user == null
        ? LoginPage()
        : GetBuilder<ControlViewModel>(
            init: ControlViewModel(),
            builder: (controller) => Scaffold(
              body: controller.currentScreen,
              bottomNavigationBar: const CustomBottomNavigationBar(),
            ),
          );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84.h,
      child: GetBuilder<ControlViewModel>(
        builder: (controller) => BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          currentIndex: controller.navigatorIndex,
          onTap: (index) {
            controller.changeCurrentScreen(index);
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.person),
              activeIcon: CustomText(
                text: 'Cart',
                fontSize: 14,
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
