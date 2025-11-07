import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Icon(Icons.power_settings_new, color: Colors.red),
                SizedBox(width: 6),
                Text(
                  "LOGOUT",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
                    icon: Icons.event_note,
                    label: 'Leave Request',
                    onTabFun: () {
                      Navigator.pushNamed(context, '/leaveRequest');
                    },
                  ),
                  _buildDashboardTile(
                    icon: Icons.description_outlined,
                    label: 'OD Request',
                    onTabFun: () {
                      Navigator.pushNamed(context, '/leaveRequest');
                    },
                  ),
                  _buildDashboardTile(
                    icon: Icons.verified_user_outlined,
                    label: 'Leave Approval',
                    onTabFun: () {

                    },
                  ),
                  _buildDashboardTile(
                    icon: Icons.access_time,
                    label: 'Attendance Regularization',
                    onTabFun: () {
                      Navigator.pushNamed(context, '/homeScreen');
                    },
                  ),
                  /* _buildDashboardTile(
                    icon: Icons.approval,
                    label: 'Regularization Approval',
                  ),
                  _buildDashboardTile(
                    icon: Icons.list_alt_outlined,
                    label: 'Regularization Listing',
                  ),*/
                ],
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomNav(context),
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
  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/homeScreen');
                },
              ),
              SizedBox(width: 10),
              Text(
                "DASHBOARD",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.calendar_month, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
