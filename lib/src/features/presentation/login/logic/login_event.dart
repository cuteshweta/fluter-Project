part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginRequested extends LoginEvent {
  final LoginRequest loginRequest;

  const LoginRequested({
    required this.loginRequest
  });

  @override
  List<Object?> get props => [loginRequest];
}
