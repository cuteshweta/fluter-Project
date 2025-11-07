import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:haritashr/src/core/network/dio_network.dart';
import 'package:haritashr/src/core/utils/log/app_logger.dart';
import 'package:haritashr/src/features/data/data_source/remote/request_login_api_impl.dart';
import 'package:haritashr/src/features/presentation/login_injections.dart';
import 'package:haritashr/src/shared/data/data_source/app_shared_preference.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initDioInjection();
  await initAppInjection();
  await initLoginInjections();
}

initAppInjection() {
  sl.registerFactory<AppSharedPrefer>(() => AppSharedPrefer(sl()));
  // sl.registerLazySingleton(() => (sl()));
}


Future<void> initDioInjection() async {
  initRootLogger();
  // DioNetwork();
  sl.registerLazySingleton(() => DioNetwork());
}
