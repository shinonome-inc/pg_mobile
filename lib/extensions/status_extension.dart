import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/util/date_formatter.dart';
import 'package:pg_mobile/util/mastodon_content_parser.dart';

extension StatusExtension on Status {
  DateTime get _createdAt => DateTime.parse(createdAt).toLocal();
  String get createdAtText => DateFormatter.formatStatusDetail(_createdAt);
  String get createdAtTimeAgoText =>
      DateFormatter.formatTimeAgoDate(_createdAt);

  String get contentText =>
      MastodonContentParser.convertHtmlToPlainText(content);
  List<String> get urls => MastodonContentParser.extractUrls(contentText);
  String get mentionsText =>
      MastodonContentParser.extractMentionsText(mentions);

  bool get containsUrl => urls.isNotEmpty;
  bool get showLinkPreview => containsUrl && mediaAttachments.isEmpty;

  bool get isPinnedToProfile => pinned ?? false;

  Uri get _uri => Uri.parse(url ?? '');
  String get uriText => _uri.toString();
}

extension StatusListExtension on List<Status> {
  Status findStatusFromId(String id) =>
      firstWhere((element) => element.id == id);
}
