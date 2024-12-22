import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/models/mastodon/status_mention.dart';
import 'package:pg_mobile/util/mastodon_content_parser.dart';

void main() {
  group('MastodonContentParser', () {
    test('convertHtmlToPlainText', () {
      const htmlText = '<p>Hello, world!<br />How are you?</p>';
      const expectedPlainText = 'Hello, world!\nHow are you?';

      final plainText = MastodonContentParser.convertHtmlToPlainText(htmlText);
      expect(plainText, expectedPlainText);
    });

    test('extractUrls', () {
      const contentText =
          'Visit https://example.com and http://test.com for more info.';
      const expectedUrls = ['https://example.com', 'http://test.com'];

      final urls = MastodonContentParser.extractUrls(contentText);
      expect(urls, expectedUrls);
    });

    test('extractMentionsText', () {
      final mentions = [
        const StatusMention(id: '1', username: 'alice', acct: 'alice', url: ''),
        const StatusMention(id: '2', username: 'bob', acct: 'bob', url: ''),
      ];
      const expectedMentionsText = '@alice @bob ';

      final mentionsText = MastodonContentParser.extractMentionsText(mentions);
      expect(mentionsText, expectedMentionsText);
    });
  });
}
