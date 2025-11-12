import 'package:haritashr/src/features/data/data_source/remote/leave/leave_api_impl.dart';
import 'package:haritashr/src/features/domain/repository/leave/abstract_leave_apply_repo.dart';
import 'package:haritashr/src/features/domain/usecases/attendance/attendance_master_usecases.dart';
import 'package:haritashr/src/features/domain/usecases/leave/leave_apply_usecase.dart';

import '../../../shared/app_injection.dart';
import '../../data/data_source/remote/attendance/attendance_api_impl.dart';
import '../../data/data_source/repository/attendance/attendanct_repo_impl.dart';
import '../../data/data_source/repository/leave/leave_apply_repo.dart';
import '../../domain/repository/attendance/attendance_abstract_repo.dart';

initAttendanceInjections() {
  sl.registerLazySingleton(() => AttendanceApiImpl(sl()));
  sl.registerLazySingleton<AttendanceRepoAbstract>(
    () => AttendanceRepoImpl(sl()),
  );
  sl.registerLazySingleton(() => AttendanceMasterUserCase(sl()));
}
