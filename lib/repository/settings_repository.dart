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
  SettingsRepository._privateConstructor();

  static final SettingsRepository _instance =
      SettingsRepository._privateConstructor();
  static SettingsRepository get instance => _instance;

  late SharedPreferences _prefs;

  Future<void> init({SharedPreferences? prefs}) async {
    if (prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    } else {
      _prefs = prefs;
    }
  }

  Future<void> writeDefaultTimelineType(TimelineType timelineType) async {
    await instance._prefs.setString(
      _SettingsKeys.defaultTimelineType,
      timelineType.text,
    );
  }

  TimelineType? readDefaultTimelineType() {
    final text = instance._prefs.getString(_SettingsKeys.defaultTimelineType);
    if (text == null) {
      return null;
    }
    final type = TimelineTypeConverter.convertTimelineTypeFromText(text);
    return type;
  }

  Future<void> writeDefaultPublishingLevel(
      PublishingLevel publishingLevel) async {
    await instance._prefs.setString(
      _SettingsKeys.defaultPublishingLevel,
      publishingLevel.text,
    );
  }

  PublishingLevel? readDefaultPublishingLevel() {
    final text =
        instance._prefs.getString(_SettingsKeys.defaultPublishingLevel);
    if (text == null) {
      return null;
    }
    final level = PublishingLevelConverter.convertPublishingLevelFromText(text);
    return level;
  }

  Future<void> writeEnableLikesNotification(bool enable) async {
    await instance._prefs.setBool(
      _SettingsKeys.enableLikesNotification,
      enable,
    );
  }

  bool? readEnableLikesNotification() {
    return instance._prefs.getBool(_SettingsKeys.enableLikesNotification);
  }

  Future<void> writeEnableReblogsNotification(bool enable) async {
    await instance._prefs.setBool(
      _SettingsKeys.enableReblogsNotification,
      enable,
    );
  }

  bool? readEnableReblogsNotification() {
    return instance._prefs.getBool(_SettingsKeys.enableReblogsNotification);
  }

  Future<void> writeEnableMentionsNotification(bool enable) async {
    await instance._prefs.setBool(
      _SettingsKeys.enableMentionsNotification,
      enable,
    );
  }

  bool? readEnableMentionsNotification() {
    return instance._prefs.getBool(_SettingsKeys.enableMentionsNotification);
  }

  Future<void> writeEnableFollowsNotification(bool enable) async {
    await instance._prefs
        .setBool(_SettingsKeys.enableFollowsNotification, enable);
  }

  bool? readEnableFollowsNotification() {
    return instance._prefs.getBool(_SettingsKeys.enableFollowsNotification);
  }
}
