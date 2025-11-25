import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/core/utils/utils/coman_snack_bar.dart';
import 'package:haritashr/src/features/domain/entities/attendance/request/mark_attendance_request.dart';
import 'package:haritashr/src/features/domain/entities/attendance/response/fetch_company_location_response.dart';
import 'package:intl/intl.dart';

import '../../../../shared/app_injection.dart';
import '../logic/attendance_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? companyLat;
  double? companyLong;
  double? currentLat;
  double? currentLong;
  bool isWithInDistance = false;
  String? _selectedCompanyBranch;
  String? punchIn = "";
  String? punchOut = "";
  String? totalPunchTime = "";

  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<AttendanceBloc>().add(FetchCompanyLocationEvent());
    context.read<AttendanceBloc>().add(FetchCompanyBranchEvent());
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _now = DateTime.now();
      });
    });
    // _startLocationUpdates();
  }

  final List<String> _companyBranchList = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceBloc, AttendanceState>(
      listener: (context, state) {
        if (state is CompanyLocationError) {
          CommonSnackBar(msg: state.msg, context: context).call();
        } else if (state is CompanyLocationSuccess) {
          companyLat = state.responseModel.result?.lat;
          companyLong = double.tryParse(
            state.responseModel.result?.long ?? "0.0",
          );
          punchIn = state.responseModel.result?.punchin;
          punchOut = state.responseModel.result?.punchout;
          totalPunchTime = state.responseModel.result?.totaltime;

          context.read<AttendanceBloc>().add(
            FetchCurrentLocationEvent(
              companyLocationLatitude: companyLat ?? 0.0,
              companyLocationLongitude: companyLong ?? 0.0,
              companyMeter: state.responseModel.result?.radiusmeter,
            ),
          );
        } else if (state is MarkAttendanceSuccess) {
          AppSharedPreference.instance?.setIsUserLogin(
            !(AppSharedPreference.instance?.isPunchIN() ?? false),
          );
          CommonSnackBar(msg: state.responseModel.msg, context: context).call();
        } else if (state is FetchCurrentLocationState) {
          isWithInDistance = state.isLocationUnder;
          currentLat = state.currentLocationLatitude;
          currentLong = state.currentLocationLongitude;
        }

        if (state.companyBranchList != null &&
            state.companyBranchList!.isNotEmpty) {
          _companyBranchList.clear();

          for (var list in state.companyBranchList!) {
            _companyBranchList.add(list.companyBranchName ?? "");
          }

          // Case A: Only one branch
          if (_companyBranchList.length == 1) {
            _selectedCompanyBranch = _companyBranchList.first;
            AppSharedPreference.instance?.setCompanyBranch(
              _selectedCompanyBranch!,
            );

            // Auto fetch company location
            context.read<AttendanceBloc>().add(FetchCompanyLocationEvent());
          }

          // Case B: More than one branch → select first branch automatically
          if (_companyBranchList.length > 1 && _selectedCompanyBranch == null) {
            _selectedCompanyBranch = _companyBranchList.first;
            AppSharedPreference.instance?.setCompanyBranch(
              _selectedCompanyBranch!,
            );

            context.read<AttendanceBloc>().add(FetchCompanyLocationEvent());
          }

          setState(() {});
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Mark Attendance',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: Column(
                  children: [

                    const SizedBox(height: 60),

                    // Current time
                    Text(
                      "${_now.hour.toString().padLeft(2, '0')}:${_now.minute.toString().padLeft(2, '0')} AM",
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      getCurrentFormattedDate(),
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),

                    const SizedBox(height: 50),
                    // Punch button
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.grey.shade100],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap:
                              (state is FetchCurrentLocationState &&
                                  state.isLocationUnder)
                              ? () {
                                  context.read<AttendanceBloc>().add(
                                    MarkAttendanceEvent(
                                      request: MarkAttendanceRequest(
                                        AppSharedPreference.instance
                                            ?.getUserId(),
                                        "P",
                                        AppSharedPreference.instance
                                            ?.getCompanyName(),
                                        companyLat,
                                        companyLong,
                                        currentLat,
                                        currentLong,
                                      ),
                                    ),
                                  );
                                }
                              : null, // disabled
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  (state is FetchCurrentLocationState &&
                                      state.isLocationUnder)
                                  ? Colors.green.shade100
                                  : Colors.grey.shade300,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 12,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.touch_app,
                                    size: 40,
                                    color:
                                        (state is FetchCurrentLocationState &&
                                            state.isLocationUnder)
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    (state is FetchCurrentLocationState &&
                                            state.isLocationUnder)
                                        ? ((AppSharedPreference.instance
                                                      ?.isPunchIN() ??
                                                  false)
                                              ? "PUNCH OUT"
                                              : "PUNCH IN")
                                        : "Outside",
                                    style: TextStyle(
                                      color:
                                          (state is FetchCurrentLocationState &&
                                              state.isLocationUnder)
                                          ? Colors.green
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButtonFormField<String>(
                        value: _selectedCompanyBranch,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        items: _companyBranchList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value == "Select Company Branch"
                                ? null
                                : value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCompanyBranch = value;
                          });
                          AppSharedPreference.instance?.setCompanyBranch(
                            _selectedCompanyBranch!,
                          );
                          if (value != "Select Company Branch") {
                            // Trigger API here
                            context.read<AttendanceBloc>().add(
                              FetchCompanyLocationEvent(),
                            );
                          }
                        },
                        validator: (value) {
                          if (value == null ||
                              value == "Select Company Branch") {
                            return "Please select company Branch";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Bottom stats row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _TimeBox(
                          icon: Icons.access_time,
                          title: 'Punch In',
                          time: punchIn ?? "",
                        ),
                        _TimeBox(
                          icon: Icons.access_time_filled,
                          title: 'Punch Out',
                          time: punchOut ?? "",
                        ),
                        _TimeBox(
                          icon: Icons.timer_outlined,
                          title: 'Total Hours',
                          time: totalPunchTime ?? "",
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Bottom Navigation
                    // _buildBottomNav(context),
                  ],
                ),
              ),
              Visibility(
                visible: state is CompanyLocationFetching,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Bottom navigation bar (same style as Dashboard)
  Widget _buildBottomNav(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(30),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.home, color: Colors.white),
            SizedBox(width: 10),
            Text(
              "HOME",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.grid_view_rounded, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_month, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/history');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _positionStream?.cancel();
    super.dispose();
  }

  String getCurrentFormattedDate() {
    DateTime now = DateTime.now();
    final month = DateFormat('MMM dd, yyyy').format(now);
    final dayName = DateFormat('EEEE').format(now);
    return "$month - $dayName";
  }
}


// Reusable widget for time info
class _TimeBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;

  const _TimeBox({required this.icon, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.redAccent),
        const SizedBox(height: 8),
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 3),
        Text(title, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }
}
