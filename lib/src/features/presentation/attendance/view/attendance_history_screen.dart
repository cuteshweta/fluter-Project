import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/shared_preference/app_shared_preference.dart';
import '../logic/attendance_bloc.dart';
import 'package:haritashr/src/features/domain/entities/attendance/request/attendance_report_request.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceHistoryScreen> createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  DateTime? _fromDate;
  DateTime? _toDate;

  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  Future<void> _pickFromDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _fromDate = picked);
    }
  }

  Future<void> _pickToDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _toDate = picked);
    }
  }

  void _loadAttendance() {
    if (_fromDate == null || _toDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both dates')),
      );
      return;
    }

    final request = AttendanceReportRequest(
      userId: AppSharedPreference.instance!.getUserId(), // Replace with actual logged-in user ID
      fromDate: _formatter.format(_fromDate!),
      toDate: _formatter.format(_toDate!),
    );

    context.read<AttendanceBloc>().add(
      AttendanceReportEvent(request: request),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Report',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          /// DATE FILTER UI
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _pickFromDate,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(_fromDate == null
                          ? "From Date"
                          : _formatter.format(_fromDate!)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _pickToDate,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(_toDate == null
                          ? "To Date"
                          : _formatter.format(_toDate!)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// LOAD BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _loadAttendance,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: Text("Load Attendance",style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// RESULT
          Expanded(
            child: BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                if (state is AttendanceReportLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is AttendanceReportError) {
                  return Center(child: Text(state.msg));
                }

                if (state is AttendanceReportSuccess) {
                  if (state.responseModel.isEmpty) {
                    return Center(child: Text('No records found'));
                  }

                  return ListView.builder(
                    itemCount: state.responseModel.length,
                    itemBuilder: (context, index) {
                      final item = state.responseModel[index];

                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text("Date: ${item.date ?? ''}"),
                          subtitle: Text("Status: ${item.status ?? ''}"),
                        ),
                      );
                    },
                  );
                }

                return Center(child: Text('Select dates to fetch data'));
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
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
              IconButton(
                icon: Icon(Icons.grid_view_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.calendar_month, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/history');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}

