import 'package:json_annotation/json_annotation.dart';

part 'company_list.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyList {
  String? id;
  @JsonKey(name: "companyname")
  String? companyName;

  CompanyList(this.id, this.companyName);

  factory CompanyList.fromJson(json) => _$CompanyListFromJson(json);

  toJson() => _$CompanyListToJson(this);
}
