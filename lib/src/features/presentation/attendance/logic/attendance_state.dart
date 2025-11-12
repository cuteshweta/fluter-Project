part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CompanyLocationFetching extends AttendanceState {
  bool? isLoading = false;

  CompanyLocationFetching({this.isLoading = false});

  @override
  List<Object> get props => [isLoading ?? false];
}

class CompanyLocationError extends AttendanceState {
  String msg;

  CompanyLocationError({this.msg = ""});

  @override
  List<Object?> get props => [msg];
}

class CompanyLocationSuccess extends AttendanceState {
  FetchCompanyLocationResponseModel responseModel;

  CompanyLocationSuccess({required this.responseModel});

  @override
  List<Object?> get props => [responseModel];
}

class MarkAttendanceSuccess extends AttendanceState {
  MarkAttendanceResponseModel responseModel;

  MarkAttendanceSuccess({required this.responseModel});

  @override
  // TODO: implement props
  List<Object?> get props => [this.responseModel];
}

class CurrentLocationState extends AttendanceState {
  double difference;

  CurrentLocationState({required this.difference});

  @override
  List<Object> get props => [difference];
}
