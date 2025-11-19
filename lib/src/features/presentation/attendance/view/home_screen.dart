import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/core/utils/utils/coman_snack_bar.dart';
import 'package:haritashr/src/features/domain/entities/attendance/request/mark_attendance_request.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AttendanceBloc>().add(FetchCompanyLocationEvent());
    // _startLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return BlocConsumer<AttendanceBloc, AttendanceState>(
      listener: (context, state) {
        if (state is CompanyLocationError) {
          CommonSnackBar(msg: state.msg, context: context).call();
        } else if (state is CompanyLocationSuccess) {
          companyLat = state.responseModel.result?.lat;
          companyLong = double.tryParse(
            state.responseModel.result?.long ?? "0.0",
          );

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
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    // Top profile header
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 26, // replace with NetworkImage if needed
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppSharedPreference.instance?.getUserName() ?? "",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.refresh, color: Colors.red, size: 24),
                      ],
                    ),

                    const SizedBox(height: 60),

                    // Current time
                    Text(
                      "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} AM",
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Feb 01, 2024 - Thursday",
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
                          onTap: () async {
                            if (state is FetchCurrentLocationState &&
                                state.isLocationUnder) {
                              context.read<AttendanceBloc>().add(
                                MarkAttendanceEvent(
                                  request: MarkAttendanceRequest(
                                    AppSharedPreference.instance?.getUserId(),
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
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.touch_app,
                                size: 40,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state is FetchCurrentLocationState &&
                                        state.isLocationUnder
                                    ? ((AppSharedPreference.instance
                                                  ?.isPunchIN() ??
                                              false)
                                          ? "PUNCH OUT"
                                          : "PUNCH IN")
                                    : "OutSide",
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Bottom stats row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _TimeBox(
                          icon: Icons.access_time,
                          title: 'Punch In',
                          time: '09:08 AM',
                        ),
                        _TimeBox(
                          icon: Icons.access_time_filled,
                          title: 'Punch Out',
                          time: '06:05 PM',
                        ),
                        _TimeBox(
                          icon: Icons.timer_outlined,
                          title: 'Total Hours',
                          time: '08:13',
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Bottom Navigation
                    _buildBottomNav(context),
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
