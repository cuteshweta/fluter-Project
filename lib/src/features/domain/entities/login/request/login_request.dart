
import 'package:json_annotation/json_annotation.dart';


part 'login_request.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class LoginRequest {
  @JsonKey(name:"mobile")
  late final String mobileNo;
  late final String msg;
  late final String imei;
  @JsonKey(name: "token")
  late final String fcmToken;
  @JsonKey(name: "companyname")
  late final String companyName;

  LoginRequest({
    required this.mobileNo,
    required this.msg,
    required this.imei,
    required this.fcmToken,
    required this.companyName
  });

  factory LoginRequest.fromJson(json) => _$LoginRequestFromJson(json);

  toJson() => _$LoginRequestToJson(this);
}
