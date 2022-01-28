import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seatrack_ui/src/views/themes/_themes.dart';

Color statusColor(int statusId) {
  switch (statusId) {
    case 3:
      {
        // running
        return AppColors.green;
      }
    case 4:
      {
        // pause
        return AppColors.gray;
      }
    case 2:
      {
        // disconnect
        return AppColors.red;
      }
    case 6:
      {
        // no gps
        return AppColors.red;
      }
    case 1:
      {
        // chua co dl
        return AppColors.red;
      }
    case 5:
      {
        // het han dv
        return AppColors.red;
      }
    default:
      {
        // orther
        return AppColors.red;
      }
  }
}

String statusString(int statusId, DateTime time) {
  DateTime d2 = DateTime.now();
  var dMins = d2.difference(time).inMinutes;
  switch (statusId) {
    case 3:
      {
        // running
        return 'Chạy';
      }
    case 4:
      {
        // pause
        return dMins > 15 ? 'Đỗ' : 'Dừng';
      }
    case 2:
      {
        // disconnect
        return 'Mất LL';
      }
    case 6:
      {
        // no gps
        return 'Mất GPS';
      }
    case 1:
      {
        // no data
        return 'Chưa có dữ liệu';
      }
    case 5:
      {
        // no gps
        return 'Hết hạn DV';
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

String timeDevice(DateTime? d1) {
  if (d1 != null) {
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

String timeToString(DateTime dt) {
  var formatter = DateFormat('dd-MM-yyyy HH:mm:ss');

  return formatter.format(dt);
}
