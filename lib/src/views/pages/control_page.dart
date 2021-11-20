import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/core/controllers/_controller.dart';
import 'package:seatrack_ui/src/core/controllers/page_controller.dart';
import 'package:seatrack_ui/src/views/pages/auth/auth_page.dart';
import 'package:seatrack_ui/src/views/widgets/custom_navigator_bar.dart';

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
