import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/controllers/_controller.dart';
import 'package:seatrack_ui/src/core/controllers/network_controller.dart';
import 'package:seatrack_ui/src/core/controllers/page_controller.dart';
import 'package:seatrack_ui/src/views/pages/auth/auth_page.dart';
import 'package:seatrack_ui/src/views/widgets/custom_navigator_bar.dart';
import 'package:seatrack_ui/src/views/widgets/custom_text.dart';

class ControlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    //   return Get.find<AuthController>().user == null
    //       ? LoginPage()
    //       : Get.find<NetworkViewModel>().connectionStatus.value == 1 ||
    //               Get.find<NetworkViewModel>().connectionStatus.value == 2
    //           ? GetBuilder<ControlViewModel>(
    //               init: ControlViewModel(),
    //               builder: (controller) => Scaffold(
    //                 body: controller.currentScreen,
    //                 bottomNavigationBar: CustomBottomNavigationBar(),
    //               ),
    //             )
    //           : NoInternetConnection();
    // });
    return Get.find<AuthController>().user == null
        ? LoginPage()
        : GetBuilder<ControlViewModel>(
            init: ControlViewModel(),
            builder: (controller) => Scaffold(
              resizeToAvoidBottomInset: false,
              body: controller.currentScreen,
              bottomNavigationBar: CustomBottomNavigationBar(),
            ),
          );
  }
}

class NoInternetConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 30.h,
            ),
            CustomText(
              text: 'Please check your internet connection..',
              fontSize: 14,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
