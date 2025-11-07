import 'package:dartz/dartz.dart';

import 'package:haritashr/src/core/network/Failure.dart';

import 'package:haritashr/src/features/domain/entities/login/request/login_request.dart';

import 'package:haritashr/src/features/domain/entities/login/response/user.dart';

import '../../../domain/repository/login/request_otp_repo.dart';
import '../remote/request_login_api_impl.dart';

class LoginRequestImpl extends RepositoryLoginAbstract{
  final LoginApiImpl loginApiImpl;

  LoginRequestImpl(this.loginApiImpl);
  @override
  Future<Either<Failure, User>> requestOtp({required LoginRequest loginResponse}) async{
    try{
      var result = loginApiImpl.requestOtp(loginResponse);
      return result;
    }catch(e){
      return Left(Failure("Unexpected Error"));
    }
  }
  
}