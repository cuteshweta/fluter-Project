
import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/features/domain/entities/leave/response/logout_response.dart';
import 'package:haritashr/src/features/domain/repository/login/logout_repo.dart';

class LogoutUseCase {
  final RepositoryLogoutAbstract repo;

  LogoutUseCase(this.repo);

  Future<Either<Failure, LogoutResponse>> call(String token) {
    return repo.logout(token);
  }
}