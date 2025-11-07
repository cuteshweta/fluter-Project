import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';
import 'package:haritashr/src/features/domain/entities/login/response/user.dart';
import 'package:haritashr/src/features/domain/usecases/login/login_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCases useCases;

  LoginBloc(this.useCases) : super(const LoginState()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    // ✅ Validation check before API call
    if (event.loginRequest.mobileNo.isEmpty ||
        event.loginRequest.mobileNo.length != 10) {
      emit(
        state.copyWith(error: "Please enter a valid 10-digit mobile number"),
      );
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    final result = await useCases.requestLogin(event.loginRequest);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.errorMessage)),
      (response) =>
          emit(state.copyWith(isLoading: false, loginResponse: response)),
    );
  }
}
