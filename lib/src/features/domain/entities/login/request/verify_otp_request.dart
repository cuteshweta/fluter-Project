
import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class VerifyOtpRequestModel{
  String userId;
  String otp;
  @JsonKey(name: "Token")
  String loginToken;

  VerifyOtpRequestModel({required this.userId, required this.otp, required this.loginToken});

  factory VerifyOtpRequestModel.fromJson(json) => _$VerifyOtpRequestModelFromJson(json);

  toJson() => _$VerifyOtpRequestModelToJson(this);
}