import 'package:pg_mobile/models/enums/publishing_level.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';

class SettingsDefaultValues {
  SettingsDefaultValues._();

  static const TimelineType defaultTimelineType = TimelineType.local;
  static const PublishingLevel defaultPublishingLevel = PublishingLevel.public;
  static const bool enableLikesNotification = true;
  static const bool enableReblogsNotification = true;
  static const bool enableMentionsNotification = true;
  static const bool enableFollowsNotification = true;
}
