import 'package:dartz/dartz.dart';
import 'package:haritashr/src/core/network/Failure.dart';
import 'package:haritashr/src/features/domain/entities/leave/response/leave_response_model.dart';

import '../../entities/leave/request/leave_report_request.dart';
import '../../entities/leave/request/leave_request_model.dart';
import '../../entities/leave/response/leave_history.dart';

abstract class AbstractLeaveApplyRepo {
  Future<Either<Failure, LeaveResponseModel>> leaveResponseModel({
    required LeaveRequestModel request,
  });

  Future<Either<Failure, List<LeaveHistory>>> leaveReport({
    required LeaveReportRequest request,
  });
}
