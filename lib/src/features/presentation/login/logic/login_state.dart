part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool isCompanyListFetch;
  final LoginResponse? loginResponse;
  final List<CompanyList>? companyList;
  final String? error;

  const LoginState({this.isLoading = false, this.isCompanyListFetch = true,  this.loginResponse, this.companyList, this.error});

  LoginState copyWith({
    bool? isLoading,
    bool? isCompanyListFetch,
    LoginResponse? loginResponse,
    List<CompanyList>? list,
    String? error,
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
  List<Object?> get props => [isLoading, isCompanyListFetch, loginResponse, error];
}
