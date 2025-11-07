import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/core/network/dio_network.dart';
import 'package:haritashr/src/core/utils/contants/network_constant.dart';
import 'package:haritashr/src/features/data/data_source/remote/abstract_request_login_api.dart';
import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';
import 'package:haritashr/src/features/domain/entities/login/response/company_list.dart';
import 'package:haritashr/src/features/domain/entities/login/response/user.dart';

class LoginApiImpl extends AbstractRequestLoginApi {
  final DioNetwork dio;

  LoginApiImpl(this.dio);

  @override
  Future<Either<Failure, User>> requestOtp(LoginRequest request) async {
    try {
      final result = await dio.appApi.post(
        getLoginUrl(),
        data: request,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      var data = result.data;
      if (data is String) {
        data = jsonDecode(data);
      }
      if (data != null) {
        return Left(Failure("Unexcepted error"));
      }
      final responseData = User.fromJson(data);
      if (responseData.success == "1") {
        return Right(responseData);
      } else {
        return Left(Failure(responseData.msg ?? "Login Failed"));
      }
    } on DioException catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  /*@override
  Future<Either<Failure, List<CompanyList>>> getCompanyList() async {
    try {
      final result = await dio.appApi.get(
        getLoginUrl(),
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      var data = result.data;
      if (data is String) {
        data = jsonDecode(data);
      }
      if (data != null) {
        return Left(Failure("Unexcepted error"));
      }
      final responseData = (data as List).map((item) => CompanyList.fromJson(data)).toList();
      if (responseData.success == "1") {
        return Right(responseData);
      } else {
        return Left(Failure(responseData.msg ?? "Login Failed"));
      }
    } on DioException catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }*/
}
