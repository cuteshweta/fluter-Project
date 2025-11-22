part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  final List<CompanyBranchList>? companyBranchList;
  final bool isLoading;

  const AttendanceState({
    this.companyBranchList,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [companyBranchList, isLoading];
}

// ---------------- Company Branch States ----------------

// Loading state
class CompanyBranchLoading extends AttendanceState {}

// Success state with data
class FetchCompanyBranchSuccess extends AttendanceState {
  final List<CompanyBranchList> companyBranchList;

  const FetchCompanyBranchSuccess({required this.companyBranchList});

  @override
  List<Object?> get props => [companyBranchList];
}

// Error state
class CompanyBranchError extends AttendanceState {
  final String msg;

  const CompanyBranchError({required this.msg});

  @override
  List<Object?> get props => [msg];
}

// ---------------- Company Location States ----------------

class CompanyLocationFetching extends AttendanceState {
  const CompanyLocationFetching({bool isLoading = true})
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading];
}

class CompanyLocationSuccess extends AttendanceState {
  final FetchCompanyLocationResponseModel responseModel;

  const CompanyLocationSuccess({required this.responseModel});

  @override
  List<Object?> get props => [responseModel];
}

class CompanyLocationError extends AttendanceState {
  final String msg;

  const CompanyLocationError({required this.msg});

  @override
  List<Object?> get props => [msg];
}

// ---------------- Mark Attendance State ----------------

class MarkAttendanceSuccess extends AttendanceState {
  final MarkAttendanceResponseModel responseModel;

  const MarkAttendanceSuccess({required this.responseModel});

  @override
  List<Object?> get props => [responseModel];
}

// ---------------- Current Location State ----------------

class CurrentLocationState extends AttendanceState {
  final double difference;

  const CurrentLocationState({required this.difference});

  @override
  List<Object> get props => [difference];
}

// ---------------- Attendance Report States ----------------

class AttendanceReportLoading extends AttendanceState {
  const AttendanceReportLoading() : super(isLoading: true);
}

class AttendanceReportSuccess extends AttendanceState {
  final List<AttendanceHistory> responseModel;

  const AttendanceReportSuccess({required this.responseModel});

  @override
  List<Object?> get props => [responseModel];
}

class AttendanceReportError extends AttendanceState {
  final String msg;

  const AttendanceReportError({required this.msg});

  @override
  List<Object?> get props => [msg];
}

// ---------------- Live Location Tracking State ----------------

class FetchCurrentLocationState extends AttendanceState {
  final double currentLocationLatitude;
  final double currentLocationLongitude;
  final bool isLocationUnder;

  const FetchCurrentLocationState({
    required this.isLocationUnder,
    required this.currentLocationLatitude,
    required this.currentLocationLongitude,
  });

  @override
  List<Object?> get props =>
      [isLocationUnder, currentLocationLatitude, currentLocationLongitude];
}
