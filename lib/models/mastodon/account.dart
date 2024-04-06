import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/account_field.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
abstract class Account with _$Account {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Account({
    String? id,
    String? username,
    String? acct,
    String? displayName,
    bool? locked,
    bool? bot,
    bool? discoverable,
    bool? group,
    String? createdAt,
    String? note,
    String? url,
    String? avatar,
    String? avatarStatic,
    String? header,
    String? headerStatic,
    int? followersCount,
    int? followingCount,
    int? statusesCount,
    List<dynamic>? emojis,
    List<AccountField>? fields,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
