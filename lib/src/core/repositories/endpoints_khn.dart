import 'package:seatrack_ui/src/helper/constants.dart';

class Endpoints {
  //////////////////////////////
  //        AUTH              //
  //////////////////////////////
  static String login() {
    return '$KHN_API_URL/home';
  }

  //////////////////////////////
  //        DEVICE            //
  //////////////////////////////
  static String getListDeviceByGroupId(int groupId) {
    return '$KHN_API_URL/device/group?id=$groupId';
  }

  //////////////////////////////
  //     GROUP DEVICE         //
  //////////////////////////////
  static String getListGroup() {
    return '$KHN_API_URL/device/group';
  }
}
