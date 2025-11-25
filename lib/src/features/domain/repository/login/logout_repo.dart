
import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/features/domain/entities/leave/response/logout_response.dart';

abstract class RepositoryLogoutAbstract{
  Future<Either<Failure, LogoutResponse>> logout(String token);
}