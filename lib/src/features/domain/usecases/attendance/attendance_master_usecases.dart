import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/fetch_company_location_response.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/mark_attendance_response.dart';

import '../../entities/attendance/request/mark_attendance_request.dart';
import '../../repository/attendance/attendance_abstract_repo.dart';

class AttendanceMasterUserCase {
  final AttendanceRepoAbstract attendanceRepo;

  AttendanceMasterUserCase(this.attendanceRepo);

  Future<Either<Failure, FetchCompanyLocationResponseModel>>
  fetchCompanyLocation() async {
    final result = await attendanceRepo.fetchCompanyLocation(
      companyName: AppSharedPreference.instance?.getCompanyName() ?? "",
    );

    return result.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        return Right(r);
      },
    );
  }

  Future<Either<Failure, MarkAttendanceResponseModel>> markAttendance({
    required MarkAttendanceRequest request,
  }) async {
    final result = await attendanceRepo.markAttendance(request: request);
    return result.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        return Right(r);
      },
    );
  }
}
