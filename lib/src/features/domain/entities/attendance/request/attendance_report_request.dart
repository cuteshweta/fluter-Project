import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/utils/shared_preference/app_shared_preference.dart';

// part 'attendance_report_request.g.dart';
//
// @JsonSerializable(fieldRename: FieldRename.none)
class AttendanceReportRequest {
  final String userId;
  final String fromDate;
  final String toDate;

  AttendanceReportRequest({
    required this.userId,
    required this.fromDate,
    required this.toDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fdate': fromDate,
      'tdate': toDate,
      'companyname': AppSharedPreference.instance?.getCompanyName() ?? "",
    };
  }
}
