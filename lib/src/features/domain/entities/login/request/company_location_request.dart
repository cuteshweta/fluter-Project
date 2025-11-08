import 'package:json_annotation/json_annotation.dart';


part 'company_location_request.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyLocationRequest{
  @JsonKey(name: "companyname")
  late final String companyName;

  CompanyLocationRequest({
    required this.companyName
  });

  factory CompanyLocationRequest.fromJson(json) => _$CompanyLocationRequestFromJson(json);

  toJson() => _$CompanyLocationRequestToJson(this);
}