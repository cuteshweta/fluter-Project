import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:haritashr/src/features/domain/entities/leave/request/leave_request_model.dart';
import 'package:haritashr/src/features/domain/entities/leave/response/leave_response_model.dart';
import 'package:haritashr/src/features/domain/usecases/leave/leave_apply_usecase.dart';

import '../../../domain/entities/leave/request/leave_report_request.dart';
import '../../../domain/entities/leave/response/leave_history.dart';

part 'leave_event.dart';

part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveApplyUseCase useCase;

  LeaveBloc(this.useCase) : super(LeaveState()) {
    on<LeaveApplyEvent>(_onLeaveApplyRequest);
    on<LeaveReportEvent>(_onLeaveReport);
  }

  Future<void> _onLeaveApplyRequest(
    LeaveApplyEvent state,
    Emitter<LeaveState> emit,
  ) async {
    emit(LeaveInitial());

    final result = await useCase.applyLeave(model: state.model);

    result.fold(
      (failure) => emit(LeaveErrorState(failure.errorMessage)),
      (success) => emit(LeaveSuccessState(success)),
    );
  }

  Future<void> _onLeaveReport(
      LeaveReportEvent event,
      Emitter<LeaveState> emit,
      ) async {
    emit(LeaveReportLoading());

    final result = await useCase.leaveReport(request: event.request);

    result.fold(
          (failure) => emit(LeaveReportError(msg: failure.errorMessage)),
          (success) => emit(LeaveReportSuccess(responseModel: success)),
    );
  }
}
