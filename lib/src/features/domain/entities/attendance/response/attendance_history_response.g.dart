// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceHistoryResponse _$AttendanceHistoryResponseFromJson(
  Map<String, dynamic> json,
) => AttendanceHistoryResponse(
  (json['status'] as num?)?.toInt(),
  (json['result'] as List<dynamic>?)?.map(AttendanceHistory.fromJson).toList(),
);

Map<String, dynamic> _$AttendanceHistoryResponseToJson(
  AttendanceHistoryResponse instance,
) => <String, dynamic>{'status': instance.status, 'result': instance.result};
