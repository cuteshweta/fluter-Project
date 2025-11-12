import 'package:json_annotation/json_annotation.dart';

part 'mark_attendance_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class MarkAttendanceRequest {
  String? userId;
  String? status;
  String? companyname;
  double? clat;
  double? clong;
  double? slat;
  double? slong;

  MarkAttendanceRequest(
    this.userId,
    this.status,
    this.companyname,
    this.clat,
    this.clong,
    this.slat,
    this.slong,
  );

  toJson() => _$MarkAttendanceRequestToJson(this);
}
