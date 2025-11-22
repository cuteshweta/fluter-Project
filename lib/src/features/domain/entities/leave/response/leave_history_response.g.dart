// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveHistoryResponse _$LeaveHistoryResponseFromJson(
  Map<String, dynamic> json,
) => LeaveHistoryResponse(
  (json['status'] as num?)?.toInt(),
  (json['result'] as List<dynamic>?)?.map(LeaveHistory.fromJson).toList(),
);

Map<String, dynamic> _$LeaveHistoryResponseToJson(
  LeaveHistoryResponse instance,
) => <String, dynamic>{'status': instance.status, 'result': instance.result};
