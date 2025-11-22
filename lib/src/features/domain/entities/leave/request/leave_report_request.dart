import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/utils/shared_preference/app_shared_preference.dart';

// part 'attendance_report_request.g.dart';
//
// @JsonSerializable(fieldRename: FieldRename.none)
class LeaveReportRequest {
  final String userId;
  final String fromDate;
  final String toDate;
  final String leaveType;

  LeaveReportRequest({
    required this.userId,
    required this.fromDate,
    required this.toDate,
    required this.leaveType,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fdate': fromDate,
      'tdate': toDate,
      'status':leaveType,
      'companyname': AppSharedPreference.instance?.getCompanyName() ?? "",
    };
  }
}
