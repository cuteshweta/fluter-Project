import 'dart:convert';
import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/core/network/dio_network.dart';
import 'package:haritashr/src/core/utils/contants/error_constants.dart';
import 'package:haritashr/src/features/data/data_source/remote/leave/abstract_leave_api.dart';

import '../../../../../core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/core/utils/contants/network_constant.dart'
    as network;

import '../../../../domain/entities/leave/request/leave_report_request.dart';
import '../../../../domain/entities/leave/request/leave_request_model.dart';
import '../../../../domain/entities/leave/response/leave_history.dart';
import '../../../../domain/entities/leave/response/leave_history_response.dart';
import '../../../../domain/entities/leave/response/leave_response_model.dart';

class LeaveApiImpl extends AbstractLeaveApi {
  DioNetwork dio;

  LeaveApiImpl(this.dio);

  @override
  Future<Either<Failure, LeaveResponseModel>> appyLeaveApi({
    required LeaveRequestModel model,
  }) async {
    try {
      Map<String, dynamic> mapHeaders = {};
      mapHeaders['TOKEN'] = AppSharedPreference.instance?.getAccessToken();
      final result = await dio.appApi.post(
        network.leaveODMaster,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: mapHeaders,
        ),
        data: model.toJson(),
      );
      print(model);

      var data = result.data;

      if (data is String) {
        data = jsonDecode(data);
      }

      final resultData = LeaveResponseModel.fromJson(data);

      if (resultData.success == "1") {
        return right(resultData);
      } else {
        return Left(Failure("$UNEXPECTED_ERROR:${resultData.msg}"));
      }
    } catch (e) {

      return Left(Failure("$UNEXPECTED_ERROR:${e.toString()}"));
    }
    throw UnimplementedError();
  }
  Future<Either<Failure, List<LeaveHistory>>> leaveReport({
    required LeaveReportRequest request,
  }) async {
    try {
      Map<String, dynamic> mapHeaders = {};
      mapHeaders['TOKEN'] = AppSharedPreference.instance?.getAccessToken();

      final response = await dio.appApi.post(
        network.leaveHistory,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: mapHeaders,
        ),
        data: request.toJson(),
      );
      print(request.toJson());
      var data = response.data;

      // String fixed = response.data.replaceAllMapped(
      //   RegExp(r'"fdate":\s*(\d{4}-\d{2}-\d{2})'),
      //       (match) => '"fdate": "${match.group(1)}"',
      // );
      //
      // String fixed1 =  fixed.replaceAllMapped(
      //   RegExp(r'"tdate":\s*(\d{4}-\d{2}-\d{2})'),
      //       (match) => '"tdate": "${match.group(1)}"',
      // );
      if (data is String) {
        // try {
          data = jsonDecode(data);
        // } catch (e) {
        //   return Left(Failure("Invalid response from server"));
        // }
      }
      final resultData = LeaveHistoryResponse.fromJson(data);

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
