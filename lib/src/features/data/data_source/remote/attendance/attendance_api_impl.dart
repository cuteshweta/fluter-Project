import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/core/network/dio_network.dart';
import 'package:haritashr/src/core/utils/contants/error_constants.dart';
import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/features/data/data_source/remote/attendance/abstract_attendance_api.dart';
import 'package:haritashr/src/features/domain/entities/attendance/request/mark_attendance_request.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/fetch_company_location_response.dart';
import 'package:haritashr/src/core/utils/contants/network_constant.dart'
    as network;
import 'package:haritashr/src/features/domain/entities/attendance/response/mark_attendance_response.dart';

import '../../../../domain/entities/attendance/request/attendance_report_request.dart';
import '../../../../domain/entities/attendance/response/attendance_history.dart';
import '../../../../domain/entities/attendance/response/attendance_history_response.dart';

class AttendanceApiImpl extends AbstractAttendanceApi {
  DioNetwork dio;

  AttendanceApiImpl(this.dio);

  @override
  Future<Either<Failure, FetchCompanyLocationResponseModel>>
  fetchCompanyLocation({required String companyName}) async {
    try {
      final result = await dio.appApi.post(
        network.fetchCompanyLocation,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {"companyname": companyName},
      );

      var data = result.data;

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
  // AttendanceReport
  // Future<Either<Failure, AttendanceHistory>> attendanceReport({
  //   required AttendanceHistory request,
  // }) async {
  //
  //   try {
  //     Map<String, dynamic> mapHeaders = {};
  //     mapHeaders['TOKEN'] = AppSharedPreference.instance?.getAccessToken();
  //     final result = await dio.appApi.post(
  //       network.attendanceHistory,
  //       options: Options(
  //         contentType: Headers.formUrlEncodedContentType,
  //         headers: mapHeaders,
  //       ),
  //       data: {
  //         'userId': '1398',
  //         'companyname': AppSharedPreference.instance?.getCompanyName() ?? "",
  //         'fdate':'2025-11-05',
  //         'tdate':'2025-12-25',
  //       },
  //     );
  //
  //     var data = result.data;
  //     if (data is String) {
  //       data = jsonDecode(data);
  //     }
  //
  //     final resultData = AttendanceHistoryResponse.fromJson(data);
  //
  //     if (resultData.status == 1) {
  //       return Right((resultData.result ?? []) as AttendanceHistory);
  //     } else {
  //       return Left(Failure(SOMETHING_WRONG));
  //     }
  //   } on DioException catch (e) {
  //     return Left(Failure("Unexpected error: ${e.toString()}"));
  //   } catch (e) {
  //     return Left(Failure("Unexpected error: ${e.toString()}"));
  //   }
  // }
  Future<Either<Failure, List<AttendanceHistory>>> attendanceReport({
    required AttendanceReportRequest request,
  }) async {
    try {
      Map<String, dynamic> mapHeaders = {};
      mapHeaders['TOKEN'] = '33d0059179a2d167779e088825542867';//AppSharedPreference.instance?.getAccessToken();

      final response = await dio.appApi.post(
        network.attendanceHistory,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: mapHeaders,
        ),
        data: request.toJson(),
      );
      var data = response.data;

      if (data is String) {
        try {
          data = jsonDecode(data);
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
