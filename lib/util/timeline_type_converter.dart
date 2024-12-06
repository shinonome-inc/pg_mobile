import 'package:pg_mobile/extensions/timeline_type_extension.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';

/// [TimelineType]に関する変換を行うクラス。
class TimelineTypeConverter {
  /// テキストと[TimelineType]を紐付けたマップ。
  static final Map<String, TimelineType> _timelineTypeMap = {
    for (var type in TimelineType.values) type.text: type,
  };

  /// テキストから[TimelineType]に変換する。
  static TimelineType? convertTimelineTypeFromText(String text) {
    if (_timelineTypeMap[text] == null) {
      return null;
    }
    return _timelineTypeMap[text]!;
  }

  /// [TimelineType]からテキストに変換する。
  static String convertTextFromTimelineType(TimelineType timelineType) {
    switch (timelineType) {
      case TimelineType.local:
        return 'ローカル';
      case TimelineType.home:
        return 'ホーム';
      case TimelineType.media:
        return 'メディア';
    }
  }
}
