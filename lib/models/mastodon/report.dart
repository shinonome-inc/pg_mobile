import 'package:freezed_annotation/freezed_annotation.dart';

part 'report.freezed.dart';
part 'report.g.dart';

@freezed
class Report with _$Report {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Report({
    required String id,
    required String actionTaken,
    required String actionTakenAt,
    String? category,
    required String comment,
    required bool forwarded,
    required String createdAt,
    List<String>? statusIds,
    List<String>? ruleIds,
    required dynamic targetAccount,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}
