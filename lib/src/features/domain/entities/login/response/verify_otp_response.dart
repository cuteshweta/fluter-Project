import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class VerifyOtpResponseModel {
  String? success;
  String? authorizedkeys;
  String? msg;
  String? name;

  VerifyOtpResponseModel(this.success, this.authorizedkeys, this.name);

  factory VerifyOtpResponseModel.fromJson(json) =>
      _$VerifyOtpResponseModelFromJson(json);

  toJson() => _$VerifyOtpResponseModelToJson(this);
}
