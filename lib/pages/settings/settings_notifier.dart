import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';
import 'package:pg_mobile/pages/settings/settings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_notifier.g.dart';

@riverpod
Future<String> appVersion(
  Ref ref, {
  Future<PackageInfo> Function() fetchPackageInfo = PackageInfo.fromPlatform,
}) async {
  try {
    final packageInfo = await fetchPackageInfo();
    return packageInfo.version;
  } catch (e) {
    return 'Unknown';
  }
}

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

  void switchEnableLikesNotification(bool enable) {
    _setEnableLikesNotification(enable);
  }

  void switchEnableReblogsNotification(bool enable) {
    _setEnableReblogsNotification(enable);
  }

  void switchEnableMentionsNotification(bool enable) {
    _setEnableMentionsNotification(enable);
  }

  void switchEnableFollowsNotification(bool enable) {
    _setEnableFollowsNotification(enable);
  }
}
