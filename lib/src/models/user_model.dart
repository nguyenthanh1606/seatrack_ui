import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id, sex, roleId, isActive;
  final String userName, fullName, idCard, email, numberPhone;
  final String? image, address_;
  final DateTime dateCreate;
  final DateTime? birthday;
  final int createBy;

  UserModel({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.idCard,
    required this.sex,
    required this.email,
    this.birthday,
    required this.numberPhone,
    required this.dateCreate,
    required this.createBy,
    this.image,
    required this.roleId,
    required this.isActive,
    this.address_,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class PrefsUser {
  final int id;
  final String username;
  final String token;
  PrefsUser({
    required this.id,
    required this.username,
    required this.token,
  });
  factory PrefsUser.fromJson(Map<String, dynamic> json) =>
      _$PrefsUserFromJson(json);

  Map<String, dynamic> toJson() => _$PrefsUserToJson(this);
}
