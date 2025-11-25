import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/features/domain/entities/leave/response/logout_response.dart';
import '../../../../../core/utils/contants/error_constants.dart';
import '../../../../domain/repository/login/logout_repo.dart';
import '../../remote/login/request_login_api_impl.dart';

class LogoutRequestImpl implements RepositoryLogoutAbstract {
  final LoginApiImpl loginApiImpl;

  LogoutRequestImpl(this.loginApiImpl);

  @override
  Future<Either<Failure, LogoutResponse>> logout(String token) async {
    try {
      return loginApiImpl.logout(token);
    } catch (e) {
      return Left(Failure(UNEXPECTED_ERROR));
    }
  }
}
