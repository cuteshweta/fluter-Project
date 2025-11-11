import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/features/domain/entities/leave/response/leave_response_model.dart';

import '../../entities/leave/request/leave_request_model.dart';
import '../../repository/leave/abstract_leave_apply_repo.dart';

class LeaveApplyUseCase {
  AbstractLeaveApplyRepo repo;

  LeaveApplyUseCase(this.repo);

  Future<Either<Failure, LeaveResponseModel>> applyLeave({
    required LeaveRequestModel model,
  }) async {
    final result = await repo.leaveResponseModel(request: model);

    return result.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        return Right(r);
      },
    );
  }
}
