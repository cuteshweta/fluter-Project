import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/core/utils/contants/error_constants.dart';
import 'package:haritashr/src/features/data/data_source/remote/attendance/attendance_api_impl.dart';
import 'package:haritashr/src/features/domain/entities/attendance/request/mark_attendance_request.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/company_branch_list.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/fetch_company_location_response.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/mark_attendance_response.dart';
import 'package:haritashr/src/features/domain/repository/attendance/attendance_abstract_repo.dart';

import '../../../../domain/entities/attendance/request/attendance_report_request.dart';
import '../../../../domain/entities/attendance/response/attendance_history.dart';

class AttendanceRepoImpl extends AttendanceRepoAbstract {
  final AttendanceApiImpl attendanceApiImpl;

  AttendanceRepoImpl(this.attendanceApiImpl);

  @override
  Future<Either<Failure, FetchCompanyLocationResponseModel>>
  fetchCompanyLocation({required String? companyName}) async {
    try {
      return attendanceApiImpl.fetchCompanyLocation(
        companyName: companyName ?? "",
      );
    } catch (e) {
      return Left(Failure("$UNEXPECTED_ERROR:${e.toString()}"));
    }
  }

  Future<Either<Failure, List<CompanyBranchList>>> requestCompanyBranchList() async {
    try {
      return attendanceApiImpl.getCompanyBranchList();
    } catch (e) {
      return Left(Failure(UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<Failure, MarkAttendanceResponseModel>> markAttendance({
    required MarkAttendanceRequest request,
  }) async {
    try {
      return attendanceApiImpl.markAttendance(request: request);
    } catch (e) {
      return Left(Failure("$UNEXPECTED_ERROR:${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<AttendanceHistory>>> attendanceReport({
    required AttendanceReportRequest request,
  }) {
    return attendanceApiImpl.attendanceReport(request: request);
  }
}
