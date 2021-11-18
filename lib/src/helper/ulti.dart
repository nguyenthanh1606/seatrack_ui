import 'package:flutter/material.dart';
import 'package:seatrack_ui/src/views/themes/_themes.dart';

Color statusColor(int statusId) {
  switch (statusId) {
    case 1:
      {
        // running
        return AppColors.green;
      }
    case 2:
      {
        // pause
        return AppColors.gray;
      }
    case 3:
      {
        // disconnect
        return AppColors.red;
      }
    case 4:
      {
        // no gps
        return AppColors.yellow;
      }
    default:
      {
        // orther
        return AppColors.red;
      }
  }
}

String statusString(int statusId) {
  switch (statusId) {
    case 1:
      {
        // running
        return 'Chạy';
      }
    case 2:
      {
        // pause
        return 'Dừng';
      }
    case 3:
      {
        // disconnect
        return 'Mất LL';
      }
    case 4:
      {
        // no gps
        return 'Mất GPS';
      }
    default:
      {
        // orther
        return 'Error';
      }
  }
}

String changeDateTime(DateTime? dt) {
  String str = dt.toString();
  String? result;
  // remove **.0000Z
  if (str.isNotEmpty) {
    result = str.substring(0, str.length - 5);
  }
  var s = result!.split(' ');
  result = s[1] + ' ' + s[0];
  return result;
}

String timeDevice(DateTime? dt) {
  if (dt != null) {
    DateTime d1 = DateTime.parse('2021-11-03 18:49:50Z');
    DateTime d2 = DateTime.now();
    var dHours = d2.difference(d1).inHours;
    if (dHours >= 24) {
      return d2.difference(d1).inDays.toString() + ' Ngày';
    } else {
      var dMinutes = d2.difference(d1).inMinutes - dHours * 60;
      return dHours.toString() + 'h' + dMinutes.toString() + 'phút';
    }
  }
  return '0';
}
