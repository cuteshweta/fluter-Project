// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_branch_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyBranchListResponse _$CompanyBranchListResponseFromJson(
  Map<String, dynamic> json,
) => CompanyBranchListResponse(
  (json['status'] as num?)?.toInt(),
  (json['result'] as List<dynamic>?)?.map(CompanyBranchList.fromJson).toList(),
);

Map<String, dynamic> _$CompanyBranchListResponseToJson(
  CompanyBranchListResponse instance,
) => <String, dynamic>{'status': instance.status, 'result': instance.result};
