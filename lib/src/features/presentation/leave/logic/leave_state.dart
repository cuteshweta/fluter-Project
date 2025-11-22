part of 'leave_bloc.dart';

class LeaveState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LeaveInitial extends LeaveState {
  @override
  List<Object> get props => [];
}

class LeaveErrorState extends LeaveState {
  String msg;

  LeaveErrorState(this.msg);

  @override
  List<Object?> get props => [msg];
}

class LeaveSuccessState extends LeaveState {
  LeaveResponseModel model;

  LeaveSuccessState(this.model);

  @override
  List<Object?> get props => [model];
}
class LeaveReportLoading extends LeaveState {}

class LeaveReportSuccess extends LeaveState {
  final List<LeaveHistory> responseModel;

  LeaveReportSuccess({required this.responseModel});
}

class LeaveReportError extends LeaveState {
  final String msg;

  LeaveReportError({required this.msg});
}
