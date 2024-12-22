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

  String get uriText => Uri.parse(url).toString();

  /// 返信の数を増やす。
  Status get addedReplyCount {
    return copyWith(repliesCount: repliesCount + 1);
  }

  /// rebloggedを切り替える。
  Status get toggleReblogged {
    return copyWith(
      reblogged: !reblogged,
      reblogsCount: reblogged ? reblogsCount - 1 : reblogsCount + 1,
    );
  }

  /// favouritedを切り替える。
  Status get toggleFavourited {
    return copyWith(
      favourited: !favourited,
      favouritesCount: favourited ? favouritesCount - 1 : favouritesCount + 1,
    );
  }

  /// pinnedを切り替える。
  Status get togglePinned => copyWith(pinned: !pinned);
}

extension StatusListExtension on List<Status> {
  /// 指定したIDに一致するStatusを更新する。
  List<Status> updateStatus(Status status) {
    return map((element) => element.id == status.id ? status : element)
        .toList();
  }

  /// 新しいStatusをリストの先頭に追加する。
  List<Status> addStatus(Status status) {
    return [status, ...this];
  }

  /// 新しいStatusのリストをリストの先頭に追加する。
  List<Status> addStatuses(List<Status> statuses) {
    return [...statuses, ...this];
  }

  /// 特定のIDに一致するStatusを削除する。
  List<Status> removeStatusById(String id) {
    return where((element) => element.id != id).toList();
  }

  /// 特定のアカウントIDに一致するStatusを削除する。
  List<Status> filterOutByAccountId(String accountId) {
    return where((status) => status.account.id != accountId).toList();
  }

  /// 特定のIDに一致するStatusを取得する。
  Status findStatusFromId(String id) =>
      firstWhere((element) => element.id == id);
}
