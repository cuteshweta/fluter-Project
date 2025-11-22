import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/core/network/dio_network.dart';
import 'package:haritashr/src/core/utils/contants/error_constants.dart';
import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/features/data/data_source/remote/attendance/abstract_attendance_api.dart';
import 'package:haritashr/src/features/domain/entities/attendance/request/mark_attendance_request.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/company_branch_list_response.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/fetch_company_location_response.dart';
import 'package:haritashr/src/core/utils/contants/network_constant.dart'
    as network;
import 'package:haritashr/src/features/domain/entities/attendance/response/mark_attendance_response.dart';

import '../../../../domain/entities/attendance/request/attendance_report_request.dart';
import '../../../../domain/entities/attendance/response/attendance_history.dart';
import '../../../../domain/entities/attendance/response/attendance_history_response.dart';
import '../../../../domain/entities/attendance/response/company_branch_list.dart';

class AttendanceApiImpl extends AbstractAttendanceApi {
  DioNetwork dio;

  AttendanceApiImpl(this.dio);


  // AssignBranchList
  @override
  Future<Either<Failure, List<CompanyBranchList>>> getCompanyBranchList() async {
    try {
      final result = await dio.appApi.post(
        network.assignBranchList,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {"companyname": AppSharedPreference.instance?.getCompanyName() ?? "",},
      );

      print(result);
      var data = result.data;

      if (data is String) {
        data = jsonDecode(data);
      }
      if (data == null) {
        return Left(Failure("Unexcepted error"));
      }
      print(data);
      final responseData = CompanyBranchListResponse.fromJson(data);
      if (responseData.status == 1) {
        return Right(responseData.result ?? []);
      } else {
        return Left(Failure(SOMETHING_WRONG));
      }
    } on DioException catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, FetchCompanyLocationResponseModel>>
  fetchCompanyLocation({required String companyName}) async {
    // print(companyName);
    try {
      final result = await dio.appApi.post(
        network.fetchCompanyLocation,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {"companyname": companyName},
      );

      var data = result.data;
      // print(result);
      if (data is String) {
        data = jsonDecode(data);
      }

      var resultData = FetchCompanyLocationResponseModel.fromJson(data);

      if (resultData.statusValue == 1) {
        return Right(resultData);
      } else {
        return Left(Failure("$UNEXPECTED_ERROR:${resultData.msg}"));
      }
    } catch (e) {
      return Left(Failure("$UNEXPECTED_ERROR:${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, MarkAttendanceResponseModel>> markAttendance({
    required MarkAttendanceRequest request,
  }) async {
    try {
      Map<String, dynamic> mapHeaders = {};
      mapHeaders['TOKEN'] = AppSharedPreference.instance?.getAccessToken();
      final result = await dio.appApi.post(
        network.attendanceMaster,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: mapHeaders,
        ),
        data: request.toJson(),
      );

      var data = result.data;
      if (data is String) {
        data = jsonDecode(data);
      }

      final resultData = MarkAttendanceResponseModel.fromJson(data);

      if (resultData.success == "1") {
        return right(resultData);
      } else {
        return Left(Failure("$UNEXPECTED_ERROR:${resultData.msg}"));
      }
    } catch (e) {
      return Left(Failure("$UNEXPECTED_ERROR:${e.toString()}"));
    }
  }

  Future<Either<Failure, List<AttendanceHistory>>> attendanceReport({
    required AttendanceReportRequest request,
  }) async {
    try {
      Map<String, dynamic> mapHeaders = {};
      mapHeaders['TOKEN'] = AppSharedPreference.instance?.getAccessToken();

      final response = await dio.appApi.post(
        network.attendanceHistory,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: mapHeaders,
        ),
        data: request.toJson(),
      );
      print(request.toJson());
      var data = response.data;
      String fixed = response.data.replaceAllMapped(
        RegExp(r'"date":\s*(\d{4}-\d{2}-\d{2})'),
            (match) => '"date": "${match.group(1)}"',
      );
      if (data is String) {
        try {
          data = jsonDecode(fixed);
        } catch (e) {
          return Left(Failure("Invalid response from server"));
        }
      }
      final resultData = AttendanceHistoryResponse.fromJson(data);

      if (resultData.status == 1) {
        return Right(resultData.result ?? []);
      } else {
        return Left(Failure("Something went wrong"));
      }
    } catch (e) {
      return Left(Failure("Unexpected error: $e"));
    }
  }
}
