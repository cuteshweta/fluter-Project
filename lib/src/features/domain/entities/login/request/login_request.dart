
import 'package:json_annotation/json_annotation.dart';


part 'login_request.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class LoginRequest {
  late final String mobileNo;
  late final String msg;
  late final String imei;
  late final String fcmToken;

  LoginRequest({
    required this.mobileNo,
    required this.msg,
    required this.imei,
    required this.fcmToken,
  });

  factory LoginRequest.fromJson(json) => _$LoginRequestFromJson(json);

  toJson() => _$LoginRequestToJson(this);
}
