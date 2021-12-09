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

  static String getDevieStageById(int deviceId, bool opt) {
    return '$KHN_API_URL/device/search?id=$deviceId${opt ? '&opt=true' : ''}';
  }

  static String getDevieStageByVNumber(String verticalNumber) {
    return '$KHN_API_URL/device/search?vhn=$verticalNumber';
  }

  //////////////////////////////
  //     GROUP DEVICE         //
  //////////////////////////////
  static String getListGroup() {
    return '$KHN_API_URL/device/group';
  }
}
