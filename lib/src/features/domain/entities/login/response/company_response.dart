import 'package:haritashr/src/features/domain/entities/login/response/company_list.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyResponse {
  String? status;
  List<CompanyList>? result;

  CompanyResponse(this.status, this.result);
}
