// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
  mobileNo: json['mobile'] as String,
  msg: json['msg'] as String,
  imei: json['imei'] as String,
  fcmToken: json['token'] as String,
  companyName: json['companyname'] as String,
);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'mobile': instance.mobileNo,
      'msg': instance.msg,
      'imei': instance.imei,
      'token': instance.fcmToken,
      'companyname': instance.companyName,
    };
