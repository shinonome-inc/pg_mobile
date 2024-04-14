import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_tag.freezed.dart';
part 'status_tag.g.dart';

@freezed
class StatusTag with _$StatusTag {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StatusTag({
    required String name,
    required String url,
  }) = _StatusTag;

  factory StatusTag.fromJson(Map<String, dynamic> json) =>
      _$StatusTagFromJson(json);
}
