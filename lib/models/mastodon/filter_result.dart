import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_result.freezed.dart';
part 'filter_result.g.dart';

@freezed
abstract class FilterResult with _$FilterResult {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FilterResult({
    required String id,
    required String username,
    required String url,
    required String acct,
  }) = _FilterResult;

  factory FilterResult.fromJson(Map<String, dynamic> json) =>
      _$FilterResultFromJson(json);
}
