import 'package:haritashr/src/features/domain/entities/attendance/response/attendance_history.dart';
import 'package:json_annotation/json_annotation.dart';

import 'attendance_history.dart';

part 'attendance_history_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AttendanceHistoryResponse {
  int? status;
  List<AttendanceHistory>? result;

  AttendanceHistoryResponse(this.status, this.result);

  factory AttendanceHistoryResponse.fromJson(json) => _$AttendanceHistoryResponseFromJson(json);

  toJson() => _$AttendanceHistoryResponseToJson(this);
}
