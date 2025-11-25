import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haritashr/src/core/utils/utils/coman_snack_bar.dart';
import 'package:haritashr/src/features/presentation/dashboard/logic/dashboard_bloc.dart';

import '../../../../core/utils/shared_preference/app_shared_preference.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Hello ${AppSharedPreference.instance?.getUserName() ?? ""}",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.power_settings_new, color: Colors.red),
                  onPressed: () {
                    context.read<DashboardBloc>().add(LogoutRequestedEvent());
                  },
                ),

                const SizedBox(width: 6),
              ],
            ),
          ),
        ],
      ),

      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardLogoutSuccess) {
            Navigator.pushReplacementNamed(context, '/logout');
          } else if (state is DashboardError) {
            CommonSnackBar(context: context, msg: state.msg).call();
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 1.1,
                        children: [
                          _buildDashboardTile(
                            icon: Icons.verified_user_outlined,
                            label: 'Mark Attendance',
                            onTabFun: () {
                              Navigator.pushNamed(context, '/homeScreen');
                            },
                          ),
                          _buildDashboardTile(
                            icon: Icons.access_time,
                            label: 'Attendance History',
                            onTabFun: () {
                              Navigator.pushNamed(context, '/history');
                            },
                          ),
                          _buildDashboardTile(
                            icon: Icons.event_note,
                            label: 'Leave Request',
                            onTabFun: () {
                              Navigator.pushNamed(
                                context,
                                '/leaveRequest',
                                arguments: "leave",
                              );
                            },
                          ),
                          _buildDashboardTile(
                            icon: Icons.calendar_view_week_rounded,
                            label: 'Leave Request History',
                            onTabFun: () {
                              Navigator.pushNamed(
                                context,
                                '/leaveRequestHistory',
                                arguments: "leave",
                              );
                            },
                          ),
                          _buildDashboardTile(
                            icon: Icons.description_outlined,
                            label: 'OD Request',
                            onTabFun: () {
                              Navigator.pushNamed(
                                context,
                                '/leaveRequest',
                                arguments: "OD",
                              );
                            },
                          ),
                          _buildDashboardTile(
                            icon: Icons.calendar_view_week_sharp,
                            label: 'OD Request History',
                            onTabFun: () {
                              Navigator.pushNamed(
                                context,
                                '/leaveRequestHistory',
                                arguments: "OD",
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
              Visibility(
                visible: state is DashboardInitial,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          );
        },
      ),
      // bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // Dashboard Tile Widget
  Widget _buildDashboardTile({
    required IconData icon,
    required String label,
    required Function() onTabFun,
  }) {
    return InkWell(
      onTap: onTabFun,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(icon, color: Colors.redAccent, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom Navigation Bar
  // Widget _buildBottomNav(BuildContext context) {
  //   return Container(
  //     decoration: const BoxDecoration(color: Colors.transparent),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  //       child: Container(
  //         height: 60,
  //         decoration: BoxDecoration(
  //           color: Colors.red,
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             IconButton(
  //               icon: Icon(Icons.home, color: Colors.white),
  //               onPressed: () {
  //                 Navigator.pushReplacementNamed(context, '/homeScreen');
  //               },
  //             ),
  //             SizedBox(width: 10),
  //             Text(
  //               "DASHBOARD",
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold,
  //                 letterSpacing: 1,
  //               ),
  //             ),
  //             SizedBox(width: 10),
  //             IconButton(
  //               icon: Icon(Icons.calendar_month, color: Colors.white),
  //               onPressed: () {
  //                 Navigator.pushReplacementNamed(context, '/history');
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
