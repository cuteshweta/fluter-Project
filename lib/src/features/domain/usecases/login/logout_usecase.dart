
import 'package:haritashr/src/features/domain/repository/login/logout_repo.dart';

class LogoutUseCase {
  final RepositoryLogoutAbstract repo;

  LogoutUseCase(this.repo);

  Future<bool> call(String token) {
    return repo.logout(token);
  }
}