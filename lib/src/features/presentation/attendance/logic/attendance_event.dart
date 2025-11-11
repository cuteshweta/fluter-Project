part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();
}

class FetchCompanyLocationEvent extends AttendanceEvent {
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
