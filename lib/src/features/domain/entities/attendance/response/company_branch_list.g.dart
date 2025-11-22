// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_branch_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyBranchList _$CompanyBranchListFromJson(Map<String, dynamic> json) =>
    CompanyBranchList(
      (json['id'] as num?)?.toInt(),
      json['companyname'] as String?,
    );

Map<String, dynamic> _$CompanyBranchListToJson(CompanyBranchList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyname': instance.companyBranchName,
    };
