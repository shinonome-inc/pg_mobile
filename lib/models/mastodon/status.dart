import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/application.dart';
import 'package:pg_mobile/models/mastodon/card.dart';

part 'status.freezed.dart';
part 'status.g.dart';

@freezed
class Status with _$Status {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Status({
    String? id,
    String? createdAt,
    String? inReplyToId,
    String? inReplyToAccountId,
    bool? sensitive,
    String? spoilerText,
    String? visibility,
    String? language,
    String? uri,
    String? url,
    int? repliesCount,
    int? reblogsCount,
    int? favouritesCount,
    bool? favourited,
    bool? reblogged,
    bool? muted,
    bool? bookmarked,
    String? content,
    dynamic reblog,
    Application? application,
    Account? account,
    List<dynamic>? mediaAttachments,
    List<dynamic>? mentions,
    List<dynamic>? tags,
    List<dynamic>? emojis,
    Card? card,
    dynamic poll,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
