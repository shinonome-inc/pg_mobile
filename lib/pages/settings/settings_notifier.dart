import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';
import 'package:pg_mobile/pages/settings/settings_state.dart';
import 'package:pg_mobile/repository/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_notifier.g.dart';

@riverpod

/// アプリのバージョンを管理するためのProvider。
///
/// アプリバージョンを取得するためだけにSettingsNotifierのstateをSettingsState型からFuture<SettingsState>型に変更するのを防ぐため、
/// appVersionだけSettingsNotifierのstateから切り離してappVersionProviderを作成している。
///
/// [fetchPackageInfo]はデフォルトでは[PackageInfo.fromPlatform]が設定されているが、テスト時にモックを設定するために引数として受け取ることができる。
///
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
    final state = _readStateFromLocalStorage();
    return state;
  }

  SettingsState _readStateFromLocalStorage() {
    return initialSettingsState.copyWith(
      defaultTimelineType:
          SettingsRepository.instance.getDefaultTimelineType() ??
              initialSettingsState.defaultTimelineType,
      defaultPublishingLevel:
          SettingsRepository.instance.getDefaultPublishingLevel() ??
              initialSettingsState.defaultPublishingLevel,
      enableLikesNotification:
          SettingsRepository.instance.getEnableLikesNotification() ??
              initialSettingsState.enableLikesNotification,
      enableReblogsNotification:
          SettingsRepository.instance.getEnableReblogsNotification() ??
              initialSettingsState.enableReblogsNotification,
      enableMentionsNotification:
          SettingsRepository.instance.getEnableMentionsNotification() ??
              initialSettingsState.enableMentionsNotification,
      enableFollowsNotification:
          SettingsRepository.instance.getEnableFollowsNotification() ??
              initialSettingsState.enableFollowsNotification,
    );
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

  Future<void> selectDefaultTimelineType(TimelineType timelineType) async {
    _setDefaultTimelineType(timelineType);
    await SettingsRepository.instance.setDefaultTimelineType(timelineType);
  }

  Future<void> selectDefaultPublishingLevel(
    PublishingLevel publishingLevel,
  ) async {
    _setDefaultPublishingLevel(publishingLevel);
    await SettingsRepository.instance
        .setDefaultPublishingLevel(publishingLevel);
  }

  Future<void> switchEnableLikesNotification(bool enable) async {
    _setEnableLikesNotification(enable);
    await SettingsRepository.instance.setEnableLikesNotification(enable);
  }

  Future<void> switchEnableReblogsNotification(bool enable) async {
    _setEnableReblogsNotification(enable);
    await SettingsRepository.instance.setEnableReblogsNotification(enable);
  }

  Future<void> switchEnableMentionsNotification(bool enable) async {
    _setEnableMentionsNotification(enable);
    await SettingsRepository.instance.setEnableMentionsNotification(enable);
  }

  Future<void> switchEnableFollowsNotification(bool enable) async {
    _setEnableFollowsNotification(enable);
    await SettingsRepository.instance.setEnableFollowsNotification(enable);
  }
}
