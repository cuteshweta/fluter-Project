import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/fetch_company_location_response.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/mark_attendance_response.dart';

import '../../entities/attendance/request/attendance_report_request.dart';
import '../../entities/attendance/request/mark_attendance_request.dart';
import '../../entities/attendance/response/attendance_history.dart';

abstract class AttendanceRepoAbstract {
  Future<Either<Failure, FetchCompanyLocationResponseModel>>
  fetchCompanyLocation({required String? companyName});

  Future<Either<Failure, MarkAttendanceResponseModel>> markAttendance({
    required MarkAttendanceRequest request,
  });

  Future<Either<Failure, List<AttendanceHistory>>> attendanceReport({
    required AttendanceReportRequest request,
  });
}
