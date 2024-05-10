import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/custom_emoji.dart';
import 'package:pg_mobile/models/mastodon/field.dart';
import 'package:pg_mobile/models/mastodon/role.dart';
import 'package:pg_mobile/models/mastodon/source.dart';

part 'credential_account.freezed.dart';
part 'credential_account.g.dart';

@freezed
class CredentialAccount with _$CredentialAccount {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CredentialAccount({
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
    required List<CustomEmoji> emojis,
    required List<Field> fields,
    required Source source,
    Role? role,
  }) = _CredentialAccount;
  factory CredentialAccount.fromJson(Map<String, dynamic> json) =>
      _$CredentialAccountFromJson(json);
}
