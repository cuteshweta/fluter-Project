import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class VerifyOtpResponseModel {
  String? success;
  String? authorizedkeys;
  String? msg;

  VerifyOtpResponseModel(this.success, this.authorizedkeys);

  factory VerifyOtpResponseModel.fromJson(json) =>
      _$VerifyOtpResponseModelFromJson(json);

  toJson() => _$VerifyOtpResponseModelToJson(this);
}
