import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/core/network/dio_network.dart';
import 'package:haritashr/src/core/utils/contants/error_constants.dart';
import 'package:haritashr/src/core/utils/contants/network_constant.dart' as network;
import 'package:haritashr/src/features/data/data_source/remote/abstract_request_login_api.dart';
import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';
import 'package:haritashr/src/features/domain/entities/login/request/verify_otp_request.dart';
import 'package:haritashr/src/features/domain/entities/login/response/company_list.dart';
import 'package:haritashr/src/features/domain/entities/login/response/company_response.dart';
import 'package:haritashr/src/features/domain/entities/login/response/user.dart';

import '../../../domain/entities/login/response/login_response.dart';


class LoginApiImpl extends AbstractRequestLoginApi {
  final DioNetwork dio;

  LoginApiImpl(this.dio);

  @override
  Future<Either<Failure, LoginResponse>> requestOtp(LoginRequest request) async {
    try {
      final result = await dio.appApi.post(
        network.loginAPi,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: request.toJson(),

      );
      var data = result.data;
      if (data is String) {
        data = jsonDecode(data);
      }
      if (data == null) {
        return Left(Failure("Unexcepted error"));
      }
      final responseData = LoginResponse.fromJson(data);
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

  @override
  Future<Either<Failure, List<CompanyList>>> getCompanyList() async {
    try {
      final result = await dio.appApi.get(
        network.companyList,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      var data = result.data;
      if (data is String) {
        data = jsonDecode(data);
      }
      if (data == null) {
        return Left(Failure("Unexcepted error"));
      }

      final responseData = CompanyResponse.fromJson(data);
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
  Future<Either<Failure, User>> verifyOtp(VerifyOtpRequestModel request) async{
    try{

      final result = await dio.appApi.post(
        network.verifyOtp,
        options: Options(contentType:  Headers.formUrlEncodedContentType),
        data: request.toJson()
      );

      var data = result.data;

      if(data is String){
        data = jsonDecode(data);
      }
      if(data == null){
        return Left(Failure(UNEXPECTED_ERROR));
      }

      final responseData = User.fromJson(data);

      if(responseData.success == "1"){
        return Right(responseData);
      }else{
        return Left(Failure("${responseData.msg}"));
      }

    }on DioException catch(e){
      return Left(Failure("Unexpected error: ${e.toString()}"));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }
}
