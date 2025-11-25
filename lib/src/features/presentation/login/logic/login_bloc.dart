import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';
import 'package:haritashr/src/features/domain/usecases/login/login_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/login/response/company_list.dart';
import '../../../domain/entities/login/response/login_response.dart';
import '../../../domain/usecases/login/logout_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCases useCases;
  final LogoutUseCase logoutUseCase;

  LoginBloc(this.useCases, this.logoutUseCase) : super(const LoginState()) {
    on<LoginRequested>(_onLoginRequested);
    on<CompanyListRequested>(_onCompanyListRequest);
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

  Future<void> _onCompanyListRequest(
    CompanyListRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isCompanyListFetch: true, error: null));
    final result = await useCases.getCompanyList();

    result.fold(
      (ifLeft) => emit(
        state.copyWith(isCompanyListFetch: false, error: ifLeft.errorMessage),
      ),
      (ifRight) =>
          emit(state.copyWith(isCompanyListFetch: false, list: ifRight)),
    );
  }
}
