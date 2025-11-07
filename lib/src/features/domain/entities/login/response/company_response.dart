import 'package:haritashr/src/features/domain/entities/login/response/company_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyResponse {
  int? status;
  List<CompanyList>? result;

  CompanyResponse(this.status, this.result);

  factory CompanyResponse.fromJson(json) => _$CompanyResponseFromJson(json);

  toJson() => _$CompanyResponseToJson(this);
}
