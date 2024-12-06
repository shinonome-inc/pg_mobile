import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';
import 'package:pg_mobile/util/timeline_type_converter.dart';

void main() {
  group('TimelineTypeConverter', () {
    test('convertTimelineTypeFromTextは正しいTimelineTypeを返す', () {
      expect(
        TimelineTypeConverter.convertTimelineTypeFromText('ローカル'),
        TimelineType.local,
      );
      expect(
        TimelineTypeConverter.convertTimelineTypeFromText('ホーム'),
        TimelineType.home,
      );
      expect(
        TimelineTypeConverter.convertTimelineTypeFromText('メディア'),
        TimelineType.media,
      );
      expect(
        TimelineTypeConverter.convertTimelineTypeFromText('無効なテキスト'),
        null,
      );
    });

    test('convertTextFromTimelineTypeは正しいテキストを返す', () {
      expect(
        TimelineTypeConverter.convertTextFromTimelineType(TimelineType.local),
        'ローカル',
      );
      expect(
        TimelineTypeConverter.convertTextFromTimelineType(TimelineType.home),
        'ホーム',
      );
      expect(
        TimelineTypeConverter.convertTextFromTimelineType(TimelineType.media),
        'メディア',
      );
    });
  });
}
