// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyResponse _$CompanyResponseFromJson(Map<String, dynamic> json) =>
    CompanyResponse(
      (json['status'] as num?)?.toInt(),
      (json['result'] as List<dynamic>?)?.map(CompanyList.fromJson).toList(),
    );

Map<String, dynamic> _$CompanyResponseToJson(CompanyResponse instance) =>
    <String, dynamic>{'status': instance.status, 'result': instance.result};
