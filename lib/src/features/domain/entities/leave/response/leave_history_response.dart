import 'package:haritashr/src/features/domain/entities/attendance/response/attendance_history.dart';
import 'package:json_annotation/json_annotation.dart';
import 'leave_history.dart';

part 'leave_history_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LeaveHistoryResponse {
  int? status;
  List<LeaveHistory>? result;

  LeaveHistoryResponse(this.status, this.result);

  factory LeaveHistoryResponse.fromJson(json) => _$LeaveHistoryResponseFromJson(json);

  toJson() => _$LeaveHistoryResponseToJson(this);
}
