import 'package:json_annotation/json_annotation.dart';

part 'company_branch_list.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyBranchList {
  int? id;
  @JsonKey(name: "companyname")
  String? companyBranchName;

  CompanyBranchList(this.id, this.companyBranchName);

  factory CompanyBranchList.fromJson(json) => _$CompanyBranchListFromJson(json);

  toJson() => _$CompanyBranchListToJson(this);
}
