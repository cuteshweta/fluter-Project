// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveHistory _$LeaveHistoryFromJson(Map<String, dynamic> json) => LeaveHistory(
  json['fdate'] as String?,
  json['tdate'] as String?,
  json['status'] as String?,
);

Map<String, dynamic> _$LeaveHistoryToJson(LeaveHistory instance) =>
    <String, dynamic>{
      'fdate': instance.fdate,
      'tdate': instance.tdate,
      'status': instance.status,
    };
