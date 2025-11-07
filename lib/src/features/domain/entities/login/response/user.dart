import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  String? success;
  String? msg;
  String? mobile;
  String? userName;
  String? userImgUrl;
  String? userId;
  String? userEmail;
  String? userpassword;
  String? otpNo;
  String? address;
  String? childuserId;
  String? bankName;
  String? ifscCode;
  String? accountNo;
  String? status;
  String? last_login_datetime;
  String? ratting;
  String? progress;
  String? authorizedkeys;

  User({
    this.success,
    this.msg,
    this.mobile,
    this.userName,
    this.userImgUrl,
    this.userId,
    this.userEmail,
    this.userpassword,
    this.otpNo,
    this.address,
    this.childuserId,
    this.bankName,
    this.ifscCode,
    this.accountNo,
    this.status,
    this.last_login_datetime,
    this.ratting,
    this.progress,
    this.authorizedkeys,
  });

  factory User.fromJson(json) =>_$UserFromJson(json);

  toJson() =>_$UserToJson(this);
}
