import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';
import 'package:haritashr/src/features/domain/entities/login/response/company_list.dart';
import 'package:haritashr/src/features/domain/entities/login/response/user.dart';

abstract class AbstractRequestLoginApi {
  Future<Either<Failure, User>> requestOtp(LoginRequest request);

  // Future<Either<Failure, List<CompanyList>>> getCompanyList();
}
