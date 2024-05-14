import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:html/parser.dart';
import 'package:pg_mobile/constants/patterns.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/application.dart';
import 'package:pg_mobile/models/mastodon/custom_emoji.dart';
import 'package:pg_mobile/models/mastodon/filter_result.dart';
import 'package:pg_mobile/models/mastodon/media_attachment.dart';
import 'package:pg_mobile/models/mastodon/poll.dart';
import 'package:pg_mobile/models/mastodon/preview_card.dart';
import 'package:pg_mobile/models/mastodon/status_mention.dart';
import 'package:pg_mobile/models/mastodon/status_tag.dart';
import 'package:pg_mobile/util/date_formatter.dart';

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
    String? url,
    String? inReplyToId,
    String? inReplyToAccountId,
    Status? reblog,
    Poll? poll,
    PreviewCard? card,
    String? language,
    String? text,
    String? editedAt,
    bool? favourited,
    bool? reblogged,
    bool? muted,
    bool? bookmarked,
    bool? pinned,
    List<FilterResult>? filtered,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}

extension StatusExtension on Status {
  String get createdAtText {
    final DateTime dateTime = DateTime.parse(createdAt).toLocal();
    final String createdAtText = DateFormatter.formatPastDate(dateTime);
    return createdAtText;
  }

  String get contentText {
    return parse(
      content.replaceAll('<br />', '\n').replaceAll('</p><p>', '\n\n'),
    ).body!.text;
  }

  List<String> get urls {
    List<String> urls = [];
    final regExp = Patterns.url;
    final matches = regExp.allMatches(contentText);
    for (var regExpMatch in matches) {
      final url = contentText.substring(regExpMatch.start, regExpMatch.end);
      urls.add(url);
    }
    return urls;
  }

  bool get containsUrl => urls.isNotEmpty;

  bool get showLinkPreview => containsUrl && mediaAttachments.isEmpty;
}
