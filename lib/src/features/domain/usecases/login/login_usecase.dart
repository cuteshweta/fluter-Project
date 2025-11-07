import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/core/utils/usecases/usecases.dart';
import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';
import 'package:haritashr/src/features/domain/entities/login/response/user.dart';
import 'package:haritashr/src/features/domain/repository/login/request_otp_repo.dart';

class LoginUseCases {
  final RepositoryLoginAbstract repositoryLoginAbstract;

  LoginUseCases(this.repositoryLoginAbstract);

  Future<Either<Failure, User>> requestLogin(LoginRequest params) async {
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

  // Future<Either<Failure, >>
}
