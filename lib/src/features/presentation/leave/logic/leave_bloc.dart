import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:haritashr/src/features/domain/entities/leave/request/leave_request_model.dart';
import 'package:haritashr/src/features/domain/entities/leave/response/leave_response_model.dart';
import 'package:haritashr/src/features/domain/usecases/leave/leave_apply_usecase.dart';

part 'leave_event.dart';

part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveApplyUseCase useCase;

  LeaveBloc(this.useCase) : super(LeaveState()) {
    on<LeaveApplyEvent>(_onLeaveApplyRequest);
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
}
