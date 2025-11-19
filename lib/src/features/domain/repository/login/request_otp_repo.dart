import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';
import 'package:haritashr/src/features/domain/entities/login/request/verify_otp_request.dart';
import 'package:haritashr/src/features/domain/entities/login/response/company_list.dart';
import 'package:haritashr/src/features/domain/entities/login/response/verify_otp_response.dart';

import '../../entities/login/response/login_response.dart';

abstract class RepositoryLoginAbstract {
  Future<Either<Failure, LoginResponse>> requestOtp({
    required LoginRequest loginResponse,
  });

  Future<Either<Failure, List<CompanyList>>> requestCompanyList();

  Future<Either<Failure, VerifyOtpResponseModel>> verifyOtpRequest(VerifyOtpRequestModel request);


}
