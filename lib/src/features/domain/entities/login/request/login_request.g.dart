// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
  mobileNo: json['mobile_no'] as String,
  msg: json['msg'] as String,
  imei: json['imei'] as String,
  fcmToken: json['fcm_token'] as String,
);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'mobile_no': instance.mobileNo,
      'msg': instance.msg,
      'imei': instance.imei,
      'fcm_token': instance.fcmToken,
    };
