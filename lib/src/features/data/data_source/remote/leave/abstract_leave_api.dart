import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import '../../../../domain/entities/leave/request/leave_request_model.dart';
import '../../../../domain/entities/leave/response/leave_response_model.dart';

abstract class AbstractLeaveApi {
  Future<Either<Failure, LeaveResponseModel>> appyLeaveApi({
    required LeaveRequestModel model,
  });
}
