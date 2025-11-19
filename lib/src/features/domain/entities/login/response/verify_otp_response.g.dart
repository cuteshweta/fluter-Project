// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpResponseModel _$VerifyOtpResponseModelFromJson(
  Map<String, dynamic> json,
) => VerifyOtpResponseModel(
  json['success'] as String?,
  json['authorizedkeys'] as String?,
  json['name'] as String?,
)..msg = json['msg'] as String?;

Map<String, dynamic> _$VerifyOtpResponseModelToJson(
  VerifyOtpResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'authorizedkeys': instance.authorizedkeys,
  'msg': instance.msg,
  'name': instance.name,
};
