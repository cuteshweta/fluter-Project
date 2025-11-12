import 'package:json_annotation/json_annotation.dart';

part 'mark_attendance_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class MarkAttendanceResponseModel {
  String? success;
  String? msg;

  MarkAttendanceResponseModel(this.success, this.msg);

  factory MarkAttendanceResponseModel.fromJson(json) =>
      _$MarkAttendanceResponseModelFromJson(json);
}
