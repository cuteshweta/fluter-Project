// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['success'] as String?,
      json['msg'] as String?,
      json['userId'] as String?,
      json['authorizedkeys'] as String?,
      json['otpsupport'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'userId': instance.userId,
      'authorizedkeys': instance.authorizedkeys,
      'otpsupport': instance.otpsupport,
    };
