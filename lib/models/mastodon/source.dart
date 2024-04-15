import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/field.dart';

part 'source.freezed.dart';
part 'source.g.dart';

@freezed
class Source with _$Source {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Source({
    required String note,
    required List<Field> fields,
    required String privacy,
    required bool sensitive,
    String? language,
    required int followRequestsCount,
  }) = _Source;
  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}
