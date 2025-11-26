import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haritashr/src/features/domain/entities/attendance/request/mark_attendance_request.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/attendance_history.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/company_branch_list.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/fetch_company_location_response.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/mark_attendance_response.dart';
import 'package:haritashr/src/features/domain/usecases/attendance/attendance_master_usecases.dart';

import '../../../domain/entities/attendance/request/attendance_report_request.dart';

part 'attendance_event.dart';

part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceMasterUserCase userCase;
  StreamSubscription<Position>? _positionStream;

  AttendanceBloc(this.userCase) : super(const AttendanceState()) {
    on<FetchCompanyLocationEvent>(_onFetchCompanyLocation);
    on<MarkAttendanceEvent>(_onMarkAttendance);
    on<CurrentLocationEvent>(_onCurrentLocation);
    on<AttendanceReportEvent>(_onAttendanceReport);
    on<FetchCurrentLocationEvent>(_onFetchCurrentLocation);
    on<FetchCompanyBranchEvent>(_onFetchCompanyBranch);
    on<UpdateLocationEvent>((event, emit) {
      emit(FetchCurrentLocationState(
        isLocationUnder: event.isInside,
        currentLocationLatitude: event.lat,
        currentLocationLongitude: event.long,
      ));

      if (!event.isInside) {
        // emit(CompanyLocationError(msg: "Location is more than allowed radius"));
      }
    });
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

  Future<void> _onAttendanceReport(
    AttendanceReportEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceReportLoading());

    final result = await userCase.attendanceReport(request: event.request);

    result.fold(
      (failure) => emit(AttendanceReportError(msg: failure.errorMessage)),
      (success) => emit(AttendanceReportSuccess(responseModel: success)),
    );
  }

  Future<void> _onFetchCurrentLocation(
    FetchCurrentLocationEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    await _handlePermission();

    _positionStream =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 0,
          ),
        ).listen((Position position) {
          double distance = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            event.companyLocationLatitude,
            event.companyLocationLongitude,
          );
          // emit(CompanyLocationFetching(isLoading: false));
          // print("metter${event.companyMeter}");
          // if (distance >= (double.parse(event.companyMeter ?? "0.0"))) {
          //   emit(CompanyLocationError(msg: "Location is more than ${event.companyMeter}"));
          // }
          add(UpdateLocationEvent(
            isInside: distance < double.parse(event.companyMeter ?? "0.0"),
            lat: position.latitude,
            long: position.longitude,
          ));
          /*context.read<AttendanceBloc>().add(

            CurrentLocationEvent(
              currentLat: position.latitude,
              currentLong: position.longitude,
              companyLat: companyLat ?? 0.0,
              companyLong: companyLong ?? 0.0,
            ),
          );*/
        });
  }

  Future<void> _handlePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }
  Future<void> _onFetchCompanyBranch(
      FetchCompanyBranchEvent event,
      Emitter<AttendanceState> emit,
      ) async {
    emit(CompanyBranchLoading());

    final result = await userCase.getCompanyBranchList();

    result.fold(
          (failure) => emit(CompanyBranchError(msg: failure.errorMessage)),
          (success) => emit(FetchCompanyBranchSuccess(companyBranchList: success)),
    );
  }


  @override
  Future<void> close() {
    _positionStream?.cancel();
    return super.close();
  }
}
