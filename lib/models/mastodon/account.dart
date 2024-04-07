import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/custom_emoji.dart';
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
    required String url,
    required String note,
    required String avatar,
    required String avatarStatic,
    required String header,
    required String headerStatic,
    required bool locked,
    required List<Field> fields,
    required List<CustomEmoji> emojis,
    required bool bot,
    required bool group,
    bool? discoverable,
    bool? noindex,
    Account? moved,
    bool? suspended,
    bool? limited,
    required DateTime createdAt,
    required DateTime lastStatusAt,
    required int statusesCount,
    required int followersCount,
    required int followingCount,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
