part of 'leave_bloc.dart';

sealed class LeaveEvent extends Equatable {
  const LeaveEvent();
}

class LeaveApplyEvent extends LeaveEvent {
  LeaveRequestModel model;

  LeaveApplyEvent(this.model);

  @override
  // TODO: implement props
  List<Object?> get props => [model];
}
