import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/application.dart';
import 'package:pg_mobile/models/mastodon/custom_emoji.dart';
import 'package:pg_mobile/models/mastodon/preview_card.dart';

part 'status.freezed.dart';
part 'status.g.dart';

@freezed
class Status with _$Status {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Status({
    required String id,
    required String uri,
    required String createdAt,
    required Account account,
    required String content,
    required String visibility,
    required bool sensitive,
    required String spoilerText,
    required List<dynamic> mediaAttachments,
    Application? application,
    required List<dynamic> mentions,
    required List<dynamic> tags,
    required List<CustomEmoji> emojis,
    required int reblogsCount,
    required int favouritesCount,
    required int repliesCount,
    String? url,
    String? inReplyToId,
    String? inReplyToAccountId,
    Status? reblog,
    dynamic poll,
    PreviewCard? card,
    String? language,
    String? text,
    String? editedAt,
    bool? favourited,
    bool? reblogged,
    bool? muted,
    bool? bookmarked,
    bool? pinned,
    dynamic filtered,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
