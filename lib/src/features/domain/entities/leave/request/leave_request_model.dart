
import 'package:json_annotation/json_annotation.dart';

part 'leave_request_model.g.dart';
@JsonSerializable(fieldRename: FieldRename.none)
class LeaveRequestModel {
  String? userId;
  String? status;
  String? companyname;
  String? fdate;
  String? tdate;
  String? remarks;

  LeaveRequestModel(
    this.userId,
    this.status,
    this.companyname,
    this.fdate,
    this.tdate,
      this.remarks,
  );

  factory LeaveRequestModel.fromJson(json) => _$LeaveRequestModelFromJson(json);

  toJson() => _$LeaveRequestModelToJson(this);
}
