import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/emoji.dart';
import 'package:pg_mobile/models/mastodon/field.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
abstract class Account with _$Account {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Account({
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
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
