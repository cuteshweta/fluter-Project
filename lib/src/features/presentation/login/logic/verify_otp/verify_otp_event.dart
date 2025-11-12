part of 'verify_otp_bloc.dart';

sealed class VerifyOtpEvent extends Equatable {}

class VerifyOtpRequestEvent extends VerifyOtpEvent {
  final VerifyOtpRequestModel otpRequest;

  VerifyOtpRequestEvent({required this.otpRequest});

  @override
  List<Object> get props =>[otpRequest];
}
