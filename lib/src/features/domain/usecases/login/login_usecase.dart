import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';
import 'package:haritashr/src/features/domain/entities/login/response/company_list.dart';
import 'package:haritashr/src/features/domain/entities/login/response/verify_otp_response.dart';
import 'package:haritashr/src/features/domain/repository/login/request_otp_repo.dart';

import '../../entities/login/request/verify_otp_request.dart';
import '../../entities/login/response/login_response.dart';

class LoginUseCases {
  final RepositoryLoginAbstract repositoryLoginAbstract;

  LoginUseCases(this.repositoryLoginAbstract);

  Future<Either<Failure, LoginResponse>> requestLogin(
    LoginRequest params,
  ) async {
    final result = await repositoryLoginAbstract.requestOtp(
      loginResponse: params,
    );
    return result.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        return Right(r);
      },
    );
  }

  Future<Either<Failure, List<CompanyList>>> getCompanyList() async {
    final result = await repositoryLoginAbstract.requestCompanyList();
    return result.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        return Right(r);
      },
    );
  }

  Future<Either<Failure, VerifyOtpResponseModel>> verifyOtp({
    required VerifyOtpRequestModel verifyOtpRequest,
  }) async {
    final result = await repositoryLoginAbstract.verifyOtpRequest(
      verifyOtpRequest,
    );
    return result.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        return Right(r);
      },
    );
  }
}
