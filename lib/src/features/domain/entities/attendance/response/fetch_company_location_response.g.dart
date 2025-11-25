// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_company_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchCompanyLocationResponseModel _$FetchCompanyLocationResponseModelFromJson(
  Map<String, dynamic> json,
) => FetchCompanyLocationResponseModel(
  json['status'],
  json['msg'] as String?,
  json['result'] == null
      ? null
      : FetchCompanyLocationItem.fromJson(json['result']),
);

Map<String, dynamic> _$FetchCompanyLocationResponseModelToJson(
  FetchCompanyLocationResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'msg': instance.msg,
  'result': instance.result,
};

FetchCompanyLocationItem _$FetchCompanyLocationItemFromJson(
  Map<String, dynamic> json,
) => FetchCompanyLocationItem(
  (json['lat'] as num?)?.toDouble(),
  json['long'] as String?,
  json['radiusmeter'] as String?,
  json['punchin'] as String?,
  json['punchout'] as String?,
  json['totaltime'] as String?,
);

Map<String, dynamic> _$FetchCompanyLocationItemToJson(
  FetchCompanyLocationItem instance,
) => <String, dynamic>{
  'lat': instance.lat,
  'long': instance.long,
  'radiusmeter': instance.radiusmeter,
  'punchin': instance.punchin,
  'punchout': instance.punchout,
  'totaltime': instance.totaltime,
};
