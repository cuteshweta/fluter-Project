import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/core/utils/utils/coman_snack_bar.dart';
import 'package:haritashr/src/features/domain/entities/leave/request/leave_request_model.dart';

import '../../../domain/entities/leave/request/leave_report_request.dart';
import '../logic/leave_bloc.dart';

class LeaveRequestScreen extends StatefulWidget {
  final String screenType;

  const LeaveRequestScreen({super.key, required this.screenType});

  @override
  State<LeaveRequestScreen> createState() {
    if (screenType == "history") {
      return _LeaveRequestHistoryScreenState();
    }
    return _LeaveRequestScreenState();
  }
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  String? leaveType;
  DateTime? fromDate;
  DateTime? toDate;
  String selectedDayType = "Full day";
  bool isCompOff = false;

  final TextEditingController durationController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController empCodeController = TextEditingController();
  final TextEditingController empNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String type = ModalRoute.of(context)!.settings.arguments as String;
    String heading = "";
    if (type == "leave") {
      heading = "Leave";
    } else
      heading = "OD";
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
          "$heading Request",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<LeaveBloc, LeaveState>(
        listener: (context, state) {
          if (state is LeaveErrorState) {
            CommonSnackBar(msg: state.msg, context: context).call();
          } else if (state is LeaveSuccessState) {
            CommonSnackBar(msg: state.model.msg, context: context).call();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Leave Type Dropdown
                /*   const Text(
                  "Leave Type",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration("Select leave type"),
                  value: leaveType,
                  items:
                      [
                        "Sick Leave",
                        "Casual Leave",
                        "Earned Leave",
                        "Maternity Leave",
                      ].map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                  onChanged: (val) {
                    setState(() => leaveType = val);
                  },
                ),
                const SizedBox(height: 16),*/

                // Date Range
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        decoration: _inputDecoration("From date").copyWith(
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () => _selectDate(context, true),
                          ),
                        ),
                        controller: TextEditingController(
                          text: fromDate != null
                              ? "${fromDate!.day}-${fromDate!.month}-${fromDate!.year}"
                              : "",
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        decoration: _inputDecoration("To date").copyWith(
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () => _selectDate(context, false),
                          ),
                        ),
                        controller: TextEditingController(
                          text: toDate != null
                              ? "${toDate!.day}-${toDate!.month}-${toDate!.year}"
                              : "",
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: reasonController,
                  decoration: _inputDecoration("Reason for $type"),
                ),

                /*
            const SizedBox(height: 20),

            const Text(
              "Is it a Comp Off?",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _toggleButton("No", !isCompOff, () {
                  setState(() => isCompOff = false);
                }),
                _toggleButton("Yes", isCompOff, () {
                  setState(() => isCompOff = true);
                }),
              ],
            ),

            const SizedBox(height: 20),

            // Employee Code with Handover Duty
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: empCodeController,
                    decoration: _inputDecoration("Employee Code"),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Handover Duty",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TextField(
              controller: empNameController,
              decoration: _inputDecoration("Employee Name"),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: phoneController,
              decoration: _inputDecoration("Applicant's phone Number"),
              keyboardType: TextInputType.phone,
            ),*/
                const SizedBox(height: 30),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: state is LeaveInitial
                        ? null
                        : () {
                            context.read<LeaveBloc>().add(
                              LeaveApplyEvent(
                                LeaveRequestModel(
                                  AppSharedPreference.instance?.getUserId(),
                                  type == "leave" ? "L" : "OD",
                                  AppSharedPreference.instance
                                      ?.getCompanyName(),
                                  fromDate != null
                                      ? "${fromDate!.year}-${fromDate!.month}-${fromDate!.day}"
                                      : "",
                                  toDate != null
                                      ? "${toDate!.year}-${toDate!.month}-${toDate!.day}"
                                      : "",
                                  reasonController.text,
                                ),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: state is LeaveInitial
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "SUBMIT",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  Widget _toggleButton(String label, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.redAccent : Colors.white,
            foregroundColor: isSelected ? Colors.white : Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Colors.redAccent),
            ),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

class _LeaveRequestHistoryScreenState extends State<LeaveRequestScreen> {
  DateTime? _fromDate;
  DateTime? _toDate;

  final DateFormat _formatter = DateFormat('yyyy-MM-dd');
  String type = "leave"; // 👈 Class level
  String heading = "L"; // 👈 Class level

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    type = ModalRoute.of(context)!.settings.arguments as String;

    heading = (type == "leave") ? "L" : "OD";
  }

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select both dates')));
      return;
    }

    final request = LeaveReportRequest(
      userId: AppSharedPreference.instance?.getUserId() ?? "",
      // Replace with actual logged-in user ID
      fromDate: _formatter.format(_fromDate!),
      toDate: _formatter.format(_toDate!),
      leaveType: (type == "leave") ? "L" : "OD",
    );

    context.read<LeaveBloc>().add(LeaveReportEvent(request: request));
  }

  @override
  Widget build(BuildContext context) {
    // final String type = ModalRoute.of(context)!.settings.arguments as String;
    // String heading = "";
    //
    // if (type == "leave") {
    //   heading = "L";
    // } else
    //   heading = "OD";

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          type == "leave" ? "Leave Report" : "OD Leave Report",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
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
                      child: Text(
                        _fromDate == null
                            ? "From Date"
                            : _formatter.format(_fromDate!),
                      ),
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
                      child: Text(
                        _toDate == null
                            ? "To Date"
                            : _formatter.format(_toDate!),
                      ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: Text(
                  "Load Leave History",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// RESULT
          Expanded(
            child: BlocBuilder<LeaveBloc, LeaveState>(
              builder: (context, state) {
                if (state is LeaveReportLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is LeaveReportError) {
                  return Center(child: Text(state.msg));
                }

                if (state is LeaveReportSuccess) {
                  if (state.responseModel.isEmpty) {
                    return Center(child: Text('No records found'));
                  }

                  return ListView.builder(
                    itemCount: state.responseModel.length,
                    itemBuilder: (context, index) {
                      final item = state.responseModel[index];

                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("From Date: ${item.fdate ?? ''}"),
                              Text("To Date: ${item.tdate ?? ''}"),
                            ],
                          ),
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
    );
  }
}
