
import 'package:json_annotation/json_annotation.dart';

part 'leave_response_model.g.dart';
@JsonSerializable(fieldRename: FieldRename.none)
class LeaveResponseModel{
  String? success;
  String? msg;

  LeaveResponseModel(this.success, this.msg);

  factory LeaveResponseModel.fromJson(json) => _$LeaveResponseModelFromJson(json);

  toJson() => _$LeaveResponseModelToJson(this);
}