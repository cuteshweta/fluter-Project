
import 'package:json_annotation/json_annotation.dart';

part 'leave_request_model.g.dart';
@JsonSerializable(fieldRename: FieldRename.none)
class LeaveRequestModel {
  String? userId;
  String? status;
  String? companyname;
  String? fdate;
  String? tdate;

  LeaveRequestModel(
    this.userId,
    this.status,
    this.companyname,
    this.fdate,
    this.tdate,
  );

  factory LeaveRequestModel.fromJson(json) => _$LeaveRequestModelFromJson(json);

  toJson() => _$LeaveRequestModelToJson(this);
}
