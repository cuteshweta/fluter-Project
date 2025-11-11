part of 'verify_otp_bloc.dart';

class VerifyOtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyOtpLoading extends VerifyOtpState {
  bool isLoading = false;

  VerifyOtpLoading({this.isLoading = false});

  @override
  List<Object?> get props => [isLoading];
}

class VerifyOtpResponse extends VerifyOtpState {
  final VerifyOtpResponseModel user;

  VerifyOtpResponse({required this.user});

  @override
  List<Object> get props => [user];
}

class ErrorVerifyOtp extends VerifyOtpState {
  final String msg;

  ErrorVerifyOtp({required this.msg});

  @override
  List<Object> get props => [msg];
}
