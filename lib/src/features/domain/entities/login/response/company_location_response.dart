import 'package:json_annotation/json_annotation.dart';

part 'company_location_response.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyLocationResponse {
  String? success;
  String? msg;
  String? userId;
  String? authorizedkeys;
  String? otpsupport;

  CompanyLocationResponse(this.success, this.msg, this.userId, this.authorizedkeys, this.otpsupport);

  factory CompanyLocationResponse.fromJson(json) => _$CompanyLocationResponseFromJson(json);

  toJson() =>_$CompanyLocationResponseToJson(this);
}