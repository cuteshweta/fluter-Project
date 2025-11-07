import 'package:flutter/material.dart';

import '../../shared/app_injection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [
            // Top profile header
            Row(
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundImage: AssetImage(
                    'assets/user.jpg',
                  ), // replace with NetworkImage if needed
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'HEY JHONE DOE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'MZ001234',
                      style: TextStyle(fontSize: 13, color: Colors.blueGrey),
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
                  onTap: () {
                    // Add your punch in logic here
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.touch_app, size: 40, color: Colors.redAccent),
                      SizedBox(height: 8),
                      Text(
                        "PUNCH IN",
                        style: TextStyle(
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
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
            )
          ],
        ),
      ),
    );
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
