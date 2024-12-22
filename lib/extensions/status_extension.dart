import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/util/date_formatter.dart';
import 'package:pg_mobile/util/status_util.dart';

extension StatusExtension on Status {
  DateTime get _createdAt => DateTime.parse(createdAt).toLocal();
  String get createdAtText => DateFormatter.formatStatusDetail(_createdAt);
  String get createdAtTimeAgoText =>
      DateFormatter.formatTimeAgoDate(_createdAt);

  String get contentText => StatusUtil.convertHtmlToPlainText(content);
  List<String> get urls => StatusUtil.extractUrls(contentText);
  String get mentionsText => StatusUtil.extractMentionsText(mentions);

  bool get containsUrl => urls.isNotEmpty;
  bool get showLinkPreview => containsUrl && mediaAttachments.isEmpty;

  bool get isPinnedToProfile => pinned ?? false;
}

extension StatusListExtension on List<Status> {
  Status findStatusFromId(String id) =>
      firstWhere((element) => element.id == id);
}
