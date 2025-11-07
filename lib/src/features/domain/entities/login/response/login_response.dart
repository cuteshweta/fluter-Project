import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponse {
  String? success;
  String? msg;
  String? userId;
  String? authorizedkeys;
  String? otpsupport;

  LoginResponse(this.success, this.msg, this.userId, this.authorizedkeys, this.otpsupport);

  factory LoginResponse.fromJson(json) => _$LoginResponseFromJson(json);

  toJson() =>_$LoginResponseToJson(this);
}