import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';
import 'package:haritashr/src/features/domain/entities/login/response/company_list.dart';
import 'package:haritashr/src/features/domain/entities/login/response/user.dart';

abstract class RepositoryLoginAbstract {
  Future<Either<Failure, User>> requestOtp({
    required LoginRequest loginResponse
  });

  // Future<Either<Failure, List<CompanyList>>> requestCompanyList();

}
