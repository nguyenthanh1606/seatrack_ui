import 'package:json_annotation/json_annotation.dart';

part 'device_model.g.dart';

@JsonSerializable()
class DeviceGroupModel {
  final int vehicleGroupID;
  final String vehicleGroup;
  final int countdv;
  bool isShow;
  List<DeviceStageModel>? listDvStage;

  DeviceGroupModel({
    required this.vehicleGroupID,
    required this.vehicleGroup,
    required this.countdv,
    this.isShow = false,
    this.listDvStage = null,
  });

  factory DeviceGroupModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceGroupModelToJson(this);
}

@JsonSerializable()
class DeviceStageModel {
  final int deviceID;
  final String vehicleNumber;
  final double latitude;
  final double longitude;
  final double? latitude_last;
  final double? longitude_last;
  final double speed;
  final int oilvalue;
  final bool statusKey;
  final bool statusDoor;
  final String? in_Out;
  final bool? sleep;
  final String theDriver;
  final DateTime dateSave;
  final bool? cooler;
  final int state;
  final String stateStr;
  final String? addr;
  DeviceInfoModel? deviceInfo;

  DeviceStageModel({
    required this.deviceID,
    required this.vehicleNumber,
    required this.latitude,
    required this.longitude,
    this.latitude_last = 0.0,
    this.longitude_last = 0.0,
    required this.speed,
    required this.oilvalue,
    required this.statusKey,
    required this.statusDoor,
    this.in_Out = "0",
    this.sleep = false,
    required this.theDriver,
    required this.dateSave,
    this.cooler = false,
    required this.state,
    required this.stateStr,
    this.addr,
    this.deviceInfo = null,
  });

  factory DeviceStageModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceStageModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceStageModelToJson(this);
}

@JsonSerializable()
class DeviceLessModel {
  final int deviceID;
  final String imei;
  final String nameDevice;
  final DateTime dateExpired;
  final String vehicleNumber;
  final bool qcvn;

  DeviceLessModel({
    required this.deviceID,
    required this.imei,
    required this.nameDevice,
    required this.dateExpired,
    required this.vehicleNumber,
    required this.qcvn,
  });

  factory DeviceLessModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceLessModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceLessModelToJson(this);
}

@JsonSerializable()
class DeviceInfoModel {
  final String vehicleGroup;
  final String simNumberCfg;
  final String networkNameCfg;
  final String typeTransportName;
  final bool isCamera;
  final int speedLimit;
  final String vehicleCategory;
  final String version;
  final int signalStatusInf;
  final String networkNameInf;
  final String serialNumberInf;
  final String simNumberInf;
  final DateTime dateSaveLast;
  final bool isTruth;
  final String? addr;
  final String imei;
  final String nameDevice;
  final DateTime dateExpired;
  final String id;
  final bool qcvn;
  DeviceInfoModel({
    required this.vehicleGroup,
    required this.simNumberCfg,
    required this.networkNameCfg,
    required this.typeTransportName,
    required this.isCamera,
    required this.speedLimit,
    required this.vehicleCategory,
    required this.version,
    required this.signalStatusInf,
    required this.networkNameInf,
    required this.serialNumberInf,
    required this.simNumberInf,
    required this.dateSaveLast,
    required this.isTruth,
    this.addr,
    required this.imei,
    required this.nameDevice,
    required this.dateExpired,
    required this.id,
    required this.qcvn,
  });
  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoModelToJson(this);
}
