import 'package:seatrack_ui/src/helper/constants.dart';

class Endpoints {
  //////////////////////////////
  //        AUTH              //
  //////////////////////////////
  static String login() {
    return '$SEA_API_URL/home/login';
  }

  //////////////////////////////
  //        USER              //
  //////////////////////////////
  static String getInfoByUserName(String username) {
    return '$SEA_API_URL/api/user/getinfobyusername/$username';
  }

  //////////////////////////////
  //        DEVICE            //
  //////////////////////////////
  static String getListDeviceByGroup(int groupId) {
    return '$SEA_API_URL/device/group?id=$groupId';
  }

  //////////////////////////////
  //     GROUP DEVICE         //
  //////////////////////////////
  static String getListGroup() {
    return '$SEA_API_URL/device/group';
  }
}
