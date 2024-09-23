import 'package:html/parser.dart';
import 'package:pg_mobile/constants/patterns.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/util/date_formatter.dart';

extension StatusExtension on Status {
  DateTime get _createdAt => DateTime.parse(createdAt).toLocal();

  String get createdAtText => DateFormatter.formatStatusDetail(_createdAt);

  String get createdAtTimeAgoText =>
      DateFormatter.formatTimeAgoDate(_createdAt);

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

  String get mentionsText {
    String mentionsText = '';
    for (var mention in mentions) {
      mentionsText += '@${mention.username} ';
    }
    return mentionsText;
  }

  bool get containsUrl => urls.isNotEmpty;

  bool get showLinkPreview => containsUrl && mediaAttachments.isEmpty;
}
