import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';
import 'package:pg_mobile/util/publishing_level_util.dart';

void main() {
  group('PublishingLevelConverter', () {
    test('convertPublishingLevelFromTextは正しいPublishingLevelを返す', () {
      expect(
        PublishingLevelConverter.convertPublishingLevelFromText('ローカル'),
        PublishingLevel.public,
      );
      expect(
        PublishingLevelConverter.convertPublishingLevelFromText('未収載'),
        PublishingLevel.quietPublic,
      );
      expect(
        PublishingLevelConverter.convertPublishingLevelFromText('フォロワー限定'),
        PublishingLevel.followers,
      );
      expect(
        PublishingLevelConverter.convertPublishingLevelFromText('DM'),
        PublishingLevel.specificPeople,
      );
      expect(
        PublishingLevelConverter.convertPublishingLevelFromText('無効なテキスト'),
        null,
      );
    });

    test('convertTextFromPublishingLevelは正しいテキストを返す', () {
      expect(
        PublishingLevelConverter.convertTextFromPublishingLevel(
            PublishingLevel.public),
        'ローカル',
      );
      expect(
        PublishingLevelConverter.convertTextFromPublishingLevel(
            PublishingLevel.quietPublic),
        '未収載',
      );
      expect(
        PublishingLevelConverter.convertTextFromPublishingLevel(
            PublishingLevel.followers),
        'フォロワー限定',
      );
      expect(
        PublishingLevelConverter.convertTextFromPublishingLevel(
            PublishingLevel.specificPeople),
        'DM',
      );
    });
  });
}
