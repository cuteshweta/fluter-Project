

import '../../../shared/app_injection.dart';
import '../../data/data_source/remote/login/request_login_api_impl.dart';
import '../../data/data_source/repository/login/logout_request_impl.dart';
import '../../domain/repository/login/logout_repo.dart';
import '../../domain/usecases/login/logout_usecase.dart';

initLogoutInjections() {
  sl.registerLazySingleton<RepositoryLogoutAbstract>(
        () => LogoutRequestImpl(sl()),
  );

  sl.registerLazySingleton(() => LogoutUseCase(sl()));

}
