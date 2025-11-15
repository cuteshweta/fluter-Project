// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequestModel _$LeaveRequestModelFromJson(Map<String, dynamic> json) =>
    LeaveRequestModel(
      json['userId'] as String?,
      json['status'] as String?,
      json['companyname'] as String?,
      json['fdate'] as String?,
      json['tdate'] as String?,
      json['remarks'] as String?,
    );

Map<String, dynamic> _$LeaveRequestModelToJson(LeaveRequestModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'status': instance.status,
      'companyname': instance.companyname,
      'fdate': instance.fdate,
      'tdate': instance.tdate,
      'remarks': instance.remarks,
    };
