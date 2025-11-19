import 'package:json_annotation/json_annotation.dart';

part 'attendance_history.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AttendanceHistory {
  final String? date;
  // @JsonKey(name: "companyname")
  String? status;

  AttendanceHistory(this.date, this.status);

  factory AttendanceHistory.fromJson(json) => _$AttendanceHistoryFromJson(json);

  toJson() => _$AttendanceHistoryToJson(this);
}
