import 'package:pg_mobile/extensions/publishing_level_extension.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';

/// [PublishingLevel]に関する変換を行うクラス。
class PublishingLevelConverter {
  /// テキストと[PublishingLevel]を紐付けたマップ。
  static final Map<String, PublishingLevel> _publishingLevelMap = {
    for (var type in PublishingLevel.values) type.text: type,
  };

  /// テキストから[PublishingLevel]に変換する。
  static PublishingLevel? convertPublishingLevelFromText(String text) {
    if (_publishingLevelMap[text] == null) {
      return null;
    }
    return _publishingLevelMap[text]!;
  }

  /// [PublishingLevel]からテキストに変換する。
  static String convertTextFromPublishingLevel(
    PublishingLevel publishingLevel,
  ) {
    switch (publishingLevel) {
      case PublishingLevel.public:
        return 'ローカル';
      case PublishingLevel.quietPublic:
        return '未収載';
      case PublishingLevel.followers:
        return 'フォロワー限定';
      case PublishingLevel.specificPeople:
        return 'DM';
    }
  }
}
