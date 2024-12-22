import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/application.dart';
import 'package:pg_mobile/models/mastodon/custom_emoji.dart';
import 'package:pg_mobile/models/mastodon/filter_result.dart';
import 'package:pg_mobile/models/mastodon/media_attachment.dart';
import 'package:pg_mobile/models/mastodon/poll.dart';
import 'package:pg_mobile/models/mastodon/preview_card.dart';
import 'package:pg_mobile/models/mastodon/status_mention.dart';
import 'package:pg_mobile/models/mastodon/status_tag.dart';

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
    required List<MediaAttachment> mediaAttachments,
    Application? application,
    required List<StatusMention> mentions,
    required List<StatusTag> tags,
    required List<CustomEmoji> emojis,
    required int reblogsCount,
    required int favouritesCount,
    required int repliesCount,
    @Default('') String url,
    String? inReplyToId,
    String? inReplyToAccountId,
    Status? reblog,
    Poll? poll,
    PreviewCard? card,
    String? language,
    String? text,
    String? editedAt,
    @Default(false) bool favourited,
    @Default(false) bool reblogged,
    @Default(false) bool muted,
    @Default(false) bool bookmarked,
    @Default(false) bool pinned,
    @Default([]) List<FilterResult> filtered,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
