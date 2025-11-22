import 'package:haritashr/src/features/domain/entities/login/response/company_list.dart';
import 'package:json_annotation/json_annotation.dart';

import 'company_branch_list.dart';

part 'company_branch_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyBranchListResponse {
  int? status;
  List<CompanyBranchList>? result;

  CompanyBranchListResponse(this.status, this.result);

  factory CompanyBranchListResponse.fromJson(json) => _$CompanyBranchListResponseFromJson(json);

  toJson() => _$CompanyBranchListResponseToJson(this);
}
