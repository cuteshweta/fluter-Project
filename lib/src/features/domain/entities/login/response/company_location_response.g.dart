// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyLocationResponse _$CompanyLocationResponseFromJson(Map<String, dynamic> json) =>
    CompanyLocationResponse(
      json['success'] as String?,
      json['msg'] as String?,
      json['user_id'] as String?,
      json['authorizedkeys'] as String?,
      json['otpsupport'] as String?,
    );

Map<String, dynamic> _$CompanyLocationResponseToJson(CompanyLocationResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'user_id': instance.userId,
      'authorizedkeys': instance.authorizedkeys,
      'otpsupport': instance.otpsupport,
    };
