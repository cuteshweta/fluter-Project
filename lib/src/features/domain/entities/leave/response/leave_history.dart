import 'package:json_annotation/json_annotation.dart';

part 'leave_history.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LeaveHistory {
  final String? date;
  // @JsonKey(name: "companyname")
  String? status;

  LeaveHistory(this.date, this.status);

  factory LeaveHistory.fromJson(json) => _$LeaveHistoryFromJson(json);

  toJson() => _$LeaveHistoryToJson(this);
}
