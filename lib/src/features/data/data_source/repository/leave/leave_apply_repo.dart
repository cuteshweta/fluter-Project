import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/features/data/data_source/remote/leave/leave_api_impl.dart';
import 'package:haritashr/src/features/domain/entities/leave/request/leave_request_model.dart';
import 'package:haritashr/src/features/domain/entities/leave/response/leave_response_model.dart';
import 'package:haritashr/src/features/domain/repository/leave/abstract_leave_apply_repo.dart';

class LeaveApplyRepo extends AbstractLeaveApplyRepo {
  LeaveApiImpl leaveApiImpl;

  LeaveApplyRepo(this.leaveApiImpl);

  @override
  Future<Either<Failure, LeaveResponseModel>> leaveResponseModel(
      {required LeaveRequestModel request}) async {
    return await leaveApiImpl.appyLeaveApi(model: request);
  }

}

