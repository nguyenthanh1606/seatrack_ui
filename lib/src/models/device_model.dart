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

  DeviceStageModel({
    required this.deviceID,
    required this.vehicleNumber,
    required this.latitude,
    required this.longitude,
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
  });

  factory DeviceStageModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceStageModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceStageModelToJson(this);
}
