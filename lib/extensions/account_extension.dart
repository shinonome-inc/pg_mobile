import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/util/status_util.dart';

extension AccountExtension on Account {
  String get noteText => StatusUtil.convertHtmlToPlainText(note);
}
