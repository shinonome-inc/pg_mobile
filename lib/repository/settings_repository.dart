import 'package:pg_mobile/extensions/publishing_level_extension.dart';
import 'package:pg_mobile/extensions/timeline_type_extension.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';
import 'package:pg_mobile/util/publishing_level_util.dart';
import 'package:pg_mobile/util/timeline_type_converter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SettingsRepositoryで使用するキーを定義。
class _SettingsKeys {
  _SettingsKeys._();

  static const defaultTimelineType = 'default_timeline_type';
  static const defaultPublishingLevel = 'default_publishing_level';
  static const enableLikesNotification = 'enable_likes_notification';
  static const enableReblogsNotification = 'enable_reblogs_notification';
  static const enableMentionsNotification = 'enable_mentions_notification';
  static const enableFollowsNotification = 'enable_follows_notification';
}

/// 設定情報をSharedPreferenceから入出力するためのRepository。。
class SettingsRepository {
  static SettingsRepository? _instance;
  final SharedPreferences _prefs;

  SettingsRepository._(this._prefs);

  static SettingsRepository get instance {
    if (_instance == null) {
      throw StateError(
        'SettingsRepository is not initialized. Call init() first.',
      );
    }
    return _instance!;
  }

  Future<void> init({SharedPreferences? prefs}) async {
    if (_instance == null) {
      final sharedPrefs = prefs ?? await SharedPreferences.getInstance();
      _instance = SettingsRepository._(sharedPrefs);
    }
  }

  Future<void> setDefaultTimelineType(TimelineType timelineType) async {
    await instance._prefs.setString(
      _SettingsKeys.defaultTimelineType,
      timelineType.text,
    );
  }

  TimelineType? getDefaultTimelineType() {
    final text = instance._prefs.getString(_SettingsKeys.defaultTimelineType);
    if (text == null) {
      return null;
    }
    final type = TimelineTypeConverter.convertTimelineTypeFromText(text);
    return type;
  }

  Future<void> setDefaultPublishingLevel(
      PublishingLevel publishingLevel) async {
    await instance._prefs.setString(
      _SettingsKeys.defaultPublishingLevel,
      publishingLevel.text,
    );
  }

  PublishingLevel? getDefaultPublishingLevel() {
    final text =
        instance._prefs.getString(_SettingsKeys.defaultPublishingLevel);
    if (text == null) {
      return null;
    }
    final level = PublishingLevelConverter.convertPublishingLevelFromText(text);
    return level;
  }

  Future<void> setEnableLikesNotification(bool enable) async {
    await instance._prefs.setBool(
      _SettingsKeys.enableLikesNotification,
      enable,
    );
  }

  bool? getEnableLikesNotification() {
    return instance._prefs.getBool(_SettingsKeys.enableLikesNotification);
  }

  Future<void> setEnableReblogsNotification(bool enable) async {
    await instance._prefs.setBool(
      _SettingsKeys.enableReblogsNotification,
      enable,
    );
  }

  bool? getEnableReblogsNotification() {
    return instance._prefs.getBool(_SettingsKeys.enableReblogsNotification);
  }

  Future<void> setEnableMentionsNotification(bool enable) async {
    await instance._prefs.setBool(
      _SettingsKeys.enableMentionsNotification,
      enable,
    );
  }

  bool? getEnableMentionsNotification() {
    return instance._prefs.getBool(_SettingsKeys.enableMentionsNotification);
  }

  Future<void> setEnableFollowsNotification(bool enable) async {
    await instance._prefs
        .setBool(_SettingsKeys.enableFollowsNotification, enable);
  }

  bool? getEnableFollowsNotification() {
    return instance._prefs.getBool(_SettingsKeys.enableFollowsNotification);
  }
}
