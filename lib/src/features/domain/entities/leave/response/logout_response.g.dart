// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutResponse _$LogoutResponseFromJson(Map<String, dynamic> json) =>
    LogoutResponse(
      json['success'] as String?,
      json['msg'] as String?,
      json['authorizedkeys'] as String?,
    );

Map<String, dynamic> _$LogoutResponseToJson(LogoutResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'authorizedkeys': instance.authorizedkeys,
    };
