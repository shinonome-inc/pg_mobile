import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/application_hash.dart';
import 'package:pg_mobile/models/emoji.dart';
import 'package:pg_mobile/models/mastodon_user.dart';
import 'package:pg_mobile/models/preview_card.dart';
import 'package:pg_mobile/models/status_mention.dart';
import 'package:pg_mobile/models/status_tag.dart';

part 'status.freezed.dart';
part 'status.g.dart';

@freezed
class Status with _$Status {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Status({
    required String id,
    required String url,
    required String createdAt,
    required MastodonUser account,
    required String content,
    required String visibility,
    required bool sensitive,
    required String spoilerText,
    required List<StatusMention> mentions,
    required List<StatusTag> tags,
    required List<Emoji> emojis,
    required int reblogsCount,
    required int favouritesCount,
    required int repliesCount,
    required bool favourited,
    required bool reblogged,
    required bool muted,
    required bool bookmarked,
    ApplicationHash? application,
    PreviewCard? card,
    required String uri,
  }) = _Status;
  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
