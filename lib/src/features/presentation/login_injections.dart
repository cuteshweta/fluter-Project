import 'package:haritashr/src/features/data/data_source/remote/request_login_api_impl.dart';
import 'package:haritashr/src/features/domain/repository/login/request_otp_repo.dart';
import 'package:haritashr/src/features/domain/usecases/login/login_usecase.dart';

import '../../shared/app_injection.dart';
import '../data/data_source/repository/login_request_impl.dart';

initLoginInjections() {
  sl.registerLazySingleton(() => LoginApiImpl(sl()));
  sl.registerLazySingleton<RepositoryLoginAbstract>(() =>LoginRequestImpl(sl()));
  sl.registerLazySingleton(() =>LoginUseCases(sl()));
}
