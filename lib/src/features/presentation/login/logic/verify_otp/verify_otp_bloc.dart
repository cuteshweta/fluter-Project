import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haritashr/src/core/utils/contants/error_constants.dart';
import 'package:haritashr/src/features/domain/entities/login/request/verify_otp_request.dart';
import 'package:haritashr/src/features/domain/entities/login/response/verify_otp_response.dart';
import 'package:haritashr/src/features/domain/usecases/login/login_usecase.dart';

part 'verify_otp_event.dart';

part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final LoginUseCases loginUseCases;

  VerifyOtpBloc(this.loginUseCases) : super(VerifyOtpState()) {
    on<VerifyOtpRequestEvent>(_onVerifyOtpRequest);
  }

  Future<void> _onVerifyOtpRequest(
    VerifyOtpRequestEvent event,
    Emitter<VerifyOtpState> emit,
  ) async {
    if (event.otpRequest.otp.length < 6) {
      emit(ErrorVerifyOtp(msg: "Please enter valid otp first"));
      return;
    }

    emit(VerifyOtpLoading(isLoading: true));

    final result = await loginUseCases.verifyOtp(
      verifyOtpRequest: event.otpRequest,
    );

    result.fold((failure) => emit(ErrorVerifyOtp(msg: failure.errorMessage)), (
      success,
    ) {
      if (success.success == "1") {
        emit(VerifyOtpResponse(user: success));
      } else {
        emit(ErrorVerifyOtp(msg: success.msg ?? SOMETHING_WRONG));
      }
    });
  }
}
