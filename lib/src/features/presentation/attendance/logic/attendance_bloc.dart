import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haritashr/src/features/domain/entities/attendance/request/mark_attendance_request.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/fetch_company_location_response.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/mark_attendance_response.dart';
import 'package:haritashr/src/features/domain/usecases/attendance/attendance_master_usecases.dart';

part 'attendance_event.dart';

part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceMasterUserCase userCase;

  AttendanceBloc(this.userCase) : super(AttendanceState()) {
    on<FetchCompanyLocationEvent>(_onFetchCompanyLocation);
    on<MarkAttendanceEvent>(_onMarkAttendance);
    on<CurrentLocationEvent>(_onCurrentLocation);
  }

  Future<void> _onFetchCompanyLocation(
    FetchCompanyLocationEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(CompanyLocationFetching(isLoading: true));

    final result = await userCase.fetchCompanyLocation();
    emit(CompanyLocationFetching(isLoading: false));

    result.fold(
      (failure) => emit(CompanyLocationError(msg: failure.errorMessage)),
      (success) => emit(CompanyLocationSuccess(responseModel: success)),
    );
  }

  Future<void> _onMarkAttendance(
    MarkAttendanceEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(CompanyLocationFetching(isLoading: true));

    if (event.request.clat == 0.0 &&
        event.request.clong == 0.0 &&
        event.request.slat == 0.0 &&
        event.request.slong == 0.0) {

      emit(CompanyLocationError(msg: "Fetching Location Please Wait..."));
      return;
    }

    final result = await userCase.markAttendance(request: event.request);

    result.fold(
      (failure) => emit(CompanyLocationError(msg: failure.errorMessage)),
      (success) => emit(MarkAttendanceSuccess(responseModel: success)),
    );
  }

  Future<void> _onCurrentLocation(
    CurrentLocationEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    double distance = Geolocator.distanceBetween(
      event.currentLat,
      event.currentLong,
      event.companyLat,
      event.companyLong,
    );

    if (distance >= 300) {
      emit(CompanyLocationError(msg: "Location is more than 300"));
    } else {
      emit(CurrentLocationState(difference: distance));
    }
  }
}
