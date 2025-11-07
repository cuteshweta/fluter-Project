part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final User? loginResponse;
  final String? error;

  const LoginState({this.isLoading = false, this.loginResponse, this.error});

  LoginState copyWith({
    bool? isLoading,
    User? loginResponse,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      loginResponse: loginResponse ?? this.loginResponse,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, loginResponse, error];
}
