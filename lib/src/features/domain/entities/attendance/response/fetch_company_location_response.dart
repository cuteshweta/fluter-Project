import 'package:json_annotation/json_annotation.dart';

part 'fetch_company_location_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class FetchCompanyLocationResponseModel {
  final dynamic status;
  String? msg;
  FetchCompanyLocationItem? result;

  FetchCompanyLocationResponseModel(this.status, this.msg, this.result);

  factory FetchCompanyLocationResponseModel.fromJson(json) =>
      _$FetchCompanyLocationResponseModelFromJson(json);

  toJson() => _$FetchCompanyLocationResponseModelToJson(this);

  int get statusValue {
    if (status is int) return status;
    if (status is String) return int.tryParse(status) ?? 0;
    return 0;
  }
}

@JsonSerializable(fieldRename: FieldRename.none)
class FetchCompanyLocationItem {
  double? lat;
  String? long;
  String? radiusmeter;
  String? punchin;
  String? punchout;
  String? totaltime;

  FetchCompanyLocationItem(
    this.lat,
    this.long,
    this.radiusmeter,
    this.punchin,
    this.punchout,
    this.totaltime,
  );

  factory FetchCompanyLocationItem.fromJson(json) =>
      _$FetchCompanyLocationItemFromJson(json);

  toJson() => _$FetchCompanyLocationItemToJson(this);
}
