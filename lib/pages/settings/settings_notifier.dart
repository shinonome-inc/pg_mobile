import 'package:pg_mobile/models/enums/publishing_level.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';
import 'package:pg_mobile/pages/Settings/Settings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_notifier.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  SettingsState build() {
    return initialSettingsState;
  }

  void _setDefaultTimelineType(TimelineType timelineType) {
    state = state.copyWith(defaultTimelineType: timelineType);
  }

  void _setDefaultPublishingLevel(PublishingLevel publishingLevel) {
    state = state.copyWith(defaultPublishingLevel: publishingLevel);
  }

  void _setEnableLikesNotification(bool enable) {
    state = state.copyWith(enableLikesNotification: enable);
  }

  void _setEnableReblogsNotification(bool enable) {
    state = state.copyWith(enableReblogsNotification: enable);
  }

  void _setEnableMentionsNotification(bool enable) {
    state = state.copyWith(enableMentionsNotification: enable);
  }

  void _setEnableFollowsNotification(bool enable) {
    state = state.copyWith(enableFollowsNotification: enable);
  }

  void _setAppVersionText(String appVersionText) {
    state = state.copyWith(appVersionText: appVersionText);
  }
}
