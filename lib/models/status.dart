import 'package:freezed_annotation/freezed_annotation.dart';

part 'status.freezed.dart';
part 'status.g.dart';

@freezed
class Status with _$Status {
  const factory Status({
    String? id,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'in_reply_to_id') String? inReplyToId,
    @JsonKey(name: 'in_reply_to_account_id') String? inReplyToAccountId,
    bool? sensitive,
    @JsonKey(name: 'spoiler_text') String? spoilerText,
    String? visibility,
    String? language,
    String? uri,
    String? url,
    @JsonKey(name: 'replies_count') int? repliesCount,
    @JsonKey(name: 'reblogs_count') int? reblogsCount,
    @JsonKey(name: 'favourites_count') int? favouritesCount,
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
  const factory Application({
    String? name,
    String? website,
  }) = _Application;

  factory Application.fromJson(Map<String, dynamic> json) =>
      _$ApplicationFromJson(json);
}

@freezed
abstract class Account with _$Account {
  const factory Account({
    String? id,
    String? username,
    String? acct,
    @JsonKey(name: 'display_name') String? displayName,
    bool? locked,
    bool? bot,
    bool? discoverable,
    bool? group,
    @JsonKey(name: 'created_at') String? createdAt,
    String? note,
    String? url,
    String? avatar,
    @JsonKey(name: 'avatar_static') String? avatarStatic,
    String? header,
    @JsonKey(name: 'header_static') String? headerStatic,
    @JsonKey(name: 'followers_count') int? followersCount,
    @JsonKey(name: 'following_count') int? followingCount,
    @JsonKey(name: 'statuses_count') int? statusesCount,
    @JsonKey(name: 'last_status_at') String? lastStatusAt,
    List<dynamic>? emojis,
    List<AccountField>? fields,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}

@freezed
abstract class AccountField with _$AccountField {
  const factory AccountField({
    String? name,
    String? value,
    @JsonKey(name: 'verified_at') String? verifiedAt,
  }) = _AccountField;

  factory AccountField.fromJson(Map<String, dynamic> json) =>
      _$AccountFieldFromJson(json);
}

@freezed
abstract class Card with _$Card {
  const factory Card({
    String? url,
    String? title,
    String? description,
    String? type,
    @JsonKey(name: 'author_name') String? authorName,
    @JsonKey(name: 'author_url') String? authorUrl,
    @JsonKey(name: 'provider_name') String? providerName,
    @JsonKey(name: 'provider_url') String? providerUrl,
    String? html,
    int? width,
    int? height,
    dynamic image,
    @JsonKey(name: 'embed_url') String? embedUrl,
  }) = _Card;

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
}
