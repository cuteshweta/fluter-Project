import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/core/utils/utils/coman_snack_bar.dart';
import 'package:haritashr/src/features/domain/entities/leave/request/leave_request_model.dart';

import '../logic/leave_bloc.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
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
                  decoration: _inputDecoration("Reason for leave"),
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
