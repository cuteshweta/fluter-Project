
import 'package:json_annotation/json_annotation.dart';

part 'logout_response.g.dart';
@JsonSerializable(fieldRename: FieldRename.none)
class LogoutResponse{
  String? success;
  String? msg;
  String? authorizedkeys;

  LogoutResponse(this.success, this.msg, this.authorizedkeys);
  factory LogoutResponse.fromJson(json) => _$LogoutResponseFromJson(json);

  toJson() => _$LogoutResponseToJson(this);
}