import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';
import 'package:haritashr/src/features/domain/entities/login/request/verify_otp_request.dart';
import 'package:haritashr/src/features/domain/entities/login/response/company_list.dart';
import 'package:haritashr/src/features/domain/entities/login/response/user.dart';

import '../../../domain/entities/login/response/login_response.dart';
import '../../../domain/entities/login/response/company_location_response.dart';
import 'package:haritashr/src/features/domain/entities/login/request/company_location_request.dart';

abstract class AbstractRequestLoginApi {
  Future<Either<Failure, LoginResponse>> requestOtp(LoginRequest request);

  Future<Either<Failure, List<CompanyList>>> getCompanyList();

  Future<Either<Failure, User>> verifyOtp(VerifyOtpRequestModel request);

  Future<Either<Failure, CompanyLocationResponse>> companyLocation(CompanyLocationRequest request);
}
