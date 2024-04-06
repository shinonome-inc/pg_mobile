import 'package:freezed_annotation/freezed_annotation.dart';

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

@freezed
abstract class Application with _$Application {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Application({
    String? name,
    String? website,
  }) = _Application;

  factory Application.fromJson(Map<String, dynamic> json) =>
      _$ApplicationFromJson(json);
}

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

@freezed
abstract class AccountField with _$AccountField {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AccountField({
    String? name,
    String? value,
    String? verifiedAt,
  }) = _AccountField;

  factory AccountField.fromJson(Map<String, dynamic> json) =>
      _$AccountFieldFromJson(json);
}

@freezed
abstract class Card with _$Card {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Card({
    String? url,
    String? title,
    String? description,
    String? type,
    String? authorName,
    String? authorUrl,
    String? providerName,
    String? providerUrl,
    String? html,
    int? width,
    int? height,
    dynamic image,
    String? embedUrl,
  }) = _Card;

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
}
