// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_attendance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkAttendanceRequest _$MarkAttendanceRequestFromJson(
  Map<String, dynamic> json,
) => MarkAttendanceRequest(
  json['userId'] as String?,
  json['status'] as String?,
  json['companyname'] as String?,
  (json['clat'] as num?)?.toDouble(),
  (json['clong'] as num?)?.toDouble(),
  (json['slat'] as num?)?.toDouble(),
  (json['slong'] as num?)?.toDouble(),
);

Map<String, dynamic> _$MarkAttendanceRequestToJson(
  MarkAttendanceRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'status': instance.status,
  'companyname': instance.companyname,
  'clat': instance.clat,
  'clong': instance.clong,
  'slat': instance.slat,
  'slong': instance.slong,
};
