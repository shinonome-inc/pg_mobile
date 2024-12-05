import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/extensions/publishing_level_extension.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';

void main() {
  group('PublishingLevelExtension', () {
    test('textが正しく表示されるか', () {
      expect(PublishingLevel.public.text, 'ローカル');
      expect(PublishingLevel.quietPublic.text, '未収載');
      expect(PublishingLevel.followers.text, 'フォロワー限定');
      expect(PublishingLevel.specificPeople.text, 'DM');
    });
  });
}
