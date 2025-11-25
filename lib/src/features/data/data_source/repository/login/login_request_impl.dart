import 'package:dartz/dartz.dart';

import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/core/utils/contants/error_constants.dart';
import 'package:haritashr/src/features/domain/entities/leave/response/logout_response.dart';

import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';
import 'package:haritashr/src/features/domain/entities/login/request/verify_otp_request.dart';
import 'package:haritashr/src/features/domain/entities/login/response/company_list.dart';
import 'package:haritashr/src/features/domain/entities/login/response/verify_otp_response.dart';


import '../../../../domain/entities/login/response/login_response.dart';
import '../../../../domain/repository/login/request_otp_repo.dart';
import '../../remote/login/request_login_api_impl.dart';

class LoginRequestImpl extends RepositoryLoginAbstract {
  final LoginApiImpl loginApiImpl;

  LoginRequestImpl(this.loginApiImpl);

  @override
  Future<Either<Failure, LoginResponse>> requestOtp({
    required LoginRequest loginResponse,
  }) async {
    try {
      var result = loginApiImpl.requestOtp(loginResponse);
      return result;
    } catch (e) {
      return Left(Failure(UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<Failure, List<CompanyList>>> requestCompanyList() async {
    try {
      return loginApiImpl.getCompanyList();
    } catch (e) {
      return Left(Failure(UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpResponseModel>> verifyOtpRequest(
      VerifyOtpRequestModel request,
      ) async {
    try {
      return loginApiImpl.verifyOtp(request);
    } catch (e) {
      return Left(Failure(UNEXPECTED_ERROR));
    }
  }
}