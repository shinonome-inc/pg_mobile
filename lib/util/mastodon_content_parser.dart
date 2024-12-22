import 'package:html/parser.dart';
import 'package:pg_mobile/constants/patterns.dart';
import 'package:pg_mobile/models/mastodon/status_mention.dart';

/// MastodonのContentに関するユーティリティクラス。
class MastodonContentParser {
  MastodonContentParser._();

  /// HTMLテキストを解析してテキストに変換する。
  static String convertHtmlToPlainText(String htmlText) {
    return parse(
      htmlText.replaceAll('<br />', '\n').replaceAll('</p><p>', '\n\n'),
    ).body!.text;
  }

  /// contentText内のURLを抽出する。
  static List<String> extractUrls(String contentText) {
    List<String> urls = [];
    final regExp = Patterns.url;
    final matches = regExp.allMatches(contentText);
    for (var regExpMatch in matches) {
      final url = contentText.substring(regExpMatch.start, regExpMatch.end);
      urls.add(url);
    }
    return urls;
  }

  /// メンションされたユーザー名を '@username' の形式で抽出
  static String extractMentionsText(List<StatusMention> mentions) {
    String mentionsText = '';
    for (var mention in mentions) {
      mentionsText += '@${mention.username} ';
    }
    return mentionsText;
  }
}
