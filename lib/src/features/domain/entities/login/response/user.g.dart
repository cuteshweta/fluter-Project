// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  success: json['success'] as String?,
  msg: json['msg'] as String?,
  mobile: json['mobile'] as String?,
  userName: json['user_name'] as String?,
  userImgUrl: json['user_img_url'] as String?,
  userId: json['user_id'] as String?,
  userEmail: json['user_email'] as String?,
  userpassword: json['userpassword'] as String?,
  otpNo: json['otp_no'] as String?,
  address: json['address'] as String?,
  childuserId: json['childuser_id'] as String?,
  bankName: json['bank_name'] as String?,
  ifscCode: json['ifsc_code'] as String?,
  accountNo: json['account_no'] as String?,
  status: json['status'] as String?,
  last_login_datetime: json['last_login_datetime'] as String?,
  ratting: json['ratting'] as String?,
  progress: json['progress'] as String?,
  authorizedkeys: json['authorizedkeys'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'success': instance.success,
  'msg': instance.msg,
  'mobile': instance.mobile,
  'user_name': instance.userName,
  'user_img_url': instance.userImgUrl,
  'user_id': instance.userId,
  'user_email': instance.userEmail,
  'userpassword': instance.userpassword,
  'otp_no': instance.otpNo,
  'address': instance.address,
  'childuser_id': instance.childuserId,
  'bank_name': instance.bankName,
  'ifsc_code': instance.ifscCode,
  'account_no': instance.accountNo,
  'status': instance.status,
  'last_login_datetime': instance.last_login_datetime,
  'ratting': instance.ratting,
  'progress': instance.progress,
  'authorizedkeys': instance.authorizedkeys,
};
