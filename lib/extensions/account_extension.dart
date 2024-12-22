import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/util/mastodon_content_parser.dart';

extension AccountExtension on Account {
  String get noteText => MastodonContentParser.convertHtmlToPlainText(note);
}
