import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_mention.freezed.dart';
part 'status_mention.g.dart';

@freezed
class StatusMention with _$StatusMention {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StatusMention({
    required String id,
    required String username,
    required String url,
    required String acct,
  }) = _StatusMention;

  factory StatusMention.fromJson(Map<String, dynamic> json) =>
      _$StatusMentionFromJson(json);
}
