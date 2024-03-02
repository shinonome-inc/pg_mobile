import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/emoji.dart';
import 'package:pg_mobile/models/field.dart';

part 'mastodon_user.freezed.dart';
part 'mastodon_user.g.dart';

@freezed
class MastodonUser with _$MastodonUser {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MastodonUser({
    required String id,
    required String username,
    required String acct,
    required String displayName,
    required bool locked,
    required bool bot,
    required DateTime createdAt,
    required String note,
    required String url,
    required String avatar,
    required String avatarStatic,
    required String header,
    required String headerStatic,
    required int followersCount,
    required int followingCount,
    required int statusesCount,
    required DateTime lastStatusAt,
    required List<Emoji> emojis,
    required List<Field> fields,
  }) = _MastodonUser;

  factory MastodonUser.fromJson(Map<String, dynamic> json) =>
      _$MastodonUserFromJson(json);
}
