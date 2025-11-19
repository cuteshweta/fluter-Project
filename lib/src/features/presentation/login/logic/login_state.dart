part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool isCompanyListFetch;
  final LoginResponse? loginResponse;
  final List<CompanyList>? companyList;
  final String? error;

  // 👇 Add logout states
  final bool isLogoutLoading;
  final bool isLogoutSuccess;

  const LoginState({this.isLogoutLoading=false,this.isLogoutSuccess=false,this.isLoading = false, this.isCompanyListFetch = true,  this.loginResponse, this.companyList, this.error});

  LoginState copyWith({
    bool? isLoading,
    bool? isCompanyListFetch,
    LoginResponse? loginResponse,
    List<CompanyList>? list,
    String? error,
    bool? isLogoutLoading,
    bool? isLogoutSuccess,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isCompanyListFetch: isCompanyListFetch ?? this.isCompanyListFetch,
      loginResponse: loginResponse ?? this.loginResponse,
      companyList: list ?? [],
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isCompanyListFetch, loginResponse, error,isLogoutLoading,
    isLogoutSuccess];
}
class LogoutInitial extends LoginState {}

class LogoutLoading extends LoginState {}

class LogoutSuccess extends LoginState {}

class LogoutFailed extends LoginState {
  final String message;
  const LogoutFailed(this.message);

  @override
  List<Object?> get props => [message];
}
