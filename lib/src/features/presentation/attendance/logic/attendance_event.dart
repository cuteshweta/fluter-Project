part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();
}

class FetchCompanyLocationEvent extends AttendanceEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class FetchCompanyBranchEvent extends AttendanceEvent {
  const FetchCompanyBranchEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MarkAttendanceEvent extends AttendanceEvent {
  MarkAttendanceRequest request;

  MarkAttendanceEvent({required this.request});

  @override
  // TODO: implement props
  List<Object?> get props => [request];
}

class CurrentLocationEvent extends AttendanceEvent {
  double currentLat;
  double currentLong;
  double companyLat;
  double companyLong;

  CurrentLocationEvent({
    required this.currentLat,
    required this.currentLong,
    required this.companyLat,
    required this.companyLong,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [currentLat, currentLong];
}

class AttendanceReportEvent extends AttendanceEvent {
  final AttendanceReportRequest request;

  AttendanceReportEvent({required this.request});

  @override
  // TODO: implement props
  List<Object?> get props => [request];
}

class FetchCurrentLocationEvent extends AttendanceEvent {
  final double companyLocationLatitude;
  final double companyLocationLongitude;
  final String? companyMeter;

  FetchCurrentLocationEvent({required this.companyLocationLatitude, required this.companyLocationLongitude, required this.companyMeter});
  @override
  List<Object?> get props => [companyLocationLatitude, companyLocationLongitude, companyMeter];
}

class UpdateLocationEvent extends AttendanceEvent {
  final bool isInside;
  final double lat;
  final double long;

  UpdateLocationEvent({
    required this.isInside,
    required this.lat,
    required this.long,
  });

  @override
  List<Object?> get props => [isInside, lat, long];
}

