import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required bool isLoading,
    required TimelineType defaultTimelineType,
    required PublishingLevel defaultPublishingLevel,
    required bool enableLikesNotification,
    required bool enableReblogsNotification,
    required bool enableMentionsNotification,
    required bool enableFollowsNotification,
  }) = _SettingsState;
}

const SettingsState initialSettingsState = SettingsState(
  isLoading: false,
  defaultTimelineType: TimelineType.local,
  defaultPublishingLevel: PublishingLevel.public,
  enableLikesNotification: true,
  enableReblogsNotification: true,
  enableMentionsNotification: true,
  enableFollowsNotification: true,
);
