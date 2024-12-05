import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/extensions/timeline_type_extension.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';

void main() {
  group('TimelineTypeExtension', () {
    test('textが正しく表示されるか', () {
      expect(TimelineType.local.text, 'ローカル');
      expect(TimelineType.home.text, 'ホーム');
      expect(TimelineType.media.text, 'メディア');
    });
  });
}
