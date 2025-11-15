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
      if (result is String) {
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
}
