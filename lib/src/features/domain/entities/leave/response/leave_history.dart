import 'package:json_annotation/json_annotation.dart';

part 'leave_history.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LeaveHistory {
  final String? fdate;
  final String? tdate;
  // @JsonKey(name: "companyname")
  String? status;

  LeaveHistory(this.fdate, this.tdate, this.status);

  factory LeaveHistory.fromJson(json) => _$LeaveHistoryFromJson(json);

  toJson() => _$LeaveHistoryToJson(this);
}
