import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seatrack_ui/src/views/pages/_page.dart';

class ControlViewModel extends GetxController {
  Widget _currentScreen = const HomePage();
  int _navigatorIndex = 2;

  Widget get currentScreen => _currentScreen;

  int get navigatorIndex => _navigatorIndex;

  changeCurrentScreen(int index) {
    _navigatorIndex = index;
    switch (index) {
      case 0:
        _currentScreen = const ReportPage();
        break;
      case 1:
        _currentScreen = const ExamplePage();
        break;
      case 2:
        _currentScreen = const HomePage();
        break;
      case 3:
        _currentScreen = const ProfilePage();
        break;
      case 4:
        _currentScreen = const MenuPage();
        break;
    }
    update();
  }
}
