import 'package:get_it/get_it.dart';
import 'package:haritashr/src/core/network/dio_network.dart';
import 'package:haritashr/src/core/utils/log/app_logger.dart';
import 'package:haritashr/src/features/presentation/attendance/attendace_injection.dart';
import 'package:haritashr/src/features/presentation/leave/leave_injection.dart';
import 'package:haritashr/src/features/presentation/login/login_injections.dart';
import 'package:haritashr/src/shared/data/data_source/app_shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/shared_preference/app_shared_preference.dart';
import '../features/presentation/login/logout_injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initDioInjection();
  await initAppInjection();
  final prefs = await SharedPreferences.getInstance();
  AppSharedPreference(sharedPreferences: prefs);
  await initLoginInjections();
  await initAttendanceInjections();
  await initLeaveInjections();
  await initLogoutInjections();
}

initAppInjection() {
  sl.registerFactory<AppSharedPrefer>(() => AppSharedPrefer(sl()));
}


Future<void> initDioInjection() async {
  initRootLogger();
  // DioNetwork();
  sl.registerLazySingleton(() => DioNetwork());
}
