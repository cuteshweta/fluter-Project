import 'package:haritashr/src/features/data/data_source/remote/leave/leave_api_impl.dart';
import 'package:haritashr/src/features/domain/repository/leave/abstract_leave_apply_repo.dart';
import 'package:haritashr/src/features/domain/usecases/leave/leave_apply_usecase.dart';

import '../../../shared/app_injection.dart';
import '../../data/data_source/repository/leave/leave_apply_repo.dart';

initLeaveInjections() {
  sl.registerLazySingleton(() => LeaveApiImpl(sl()));
  sl.registerLazySingleton<AbstractLeaveApplyRepo>(() =>LeaveApplyRepo(sl()));
  sl.registerLazySingleton(() =>LeaveApplyUseCase(sl()));
}