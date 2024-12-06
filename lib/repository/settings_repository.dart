import 'package:pg_mobile/constants/settings_default_values.dart';
import 'package:pg_mobile/constants/settings_keys.dart';
import 'package:pg_mobile/extensions/publishing_level_extension.dart';
import 'package:pg_mobile/extensions/timeline_type_extension.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';
import 'package:pg_mobile/util/publishing_level_util.dart';
import 'package:pg_mobile/util/timeline_type_converter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final SharedPreferences _prefs;

  SettingsRepository(this._prefs);

  Future<void> setDefaultTimelineType(TimelineType timelineType) async {
    await _prefs.setString(
      SettingsKeys.defaultTimelineType,
      timelineType.text,
    );
  }

  TimelineType getDefaultTimelineType() {
    final text = _prefs.getString(SettingsKeys.defaultTimelineType);
    if (text == null) {
      return SettingsDefaultValues.defaultTimelineType;
    }
    final type = TimelineTypeConverter.convertTimelineTypeFromText(text);
    if (type == null) {
      return SettingsDefaultValues.defaultTimelineType;
    }
    return type;
  }

  Future<void> setDefaultPublishingLevel(
    PublishingLevel publishingLevel,
  ) async {
    await _prefs.setString(
      SettingsKeys.defaultPublishingLevel,
      publishingLevel.text,
    );
  }

  PublishingLevel getDefaultPublishingLevel() {
    final text = _prefs.getString(SettingsKeys.defaultPublishingLevel);
    if (text == null) {
      return SettingsDefaultValues.defaultPublishingLevel;
    }
    final level = PublishingLevelConverter.convertPublishingLevelFromText(text);
    if (level == null) {
      return SettingsDefaultValues.defaultPublishingLevel;
    }
    return level;
  }

  Future<void> setEnableLikesNotification(bool enable) async {
    await _prefs.setBool(SettingsKeys.enableLikesNotification, enable);
  }

  bool getEnableLikesNotification() {
    return _prefs.getBool(SettingsKeys.enableLikesNotification) ??
        SettingsDefaultValues.enableLikesNotification;
  }

  Future<void> setEnableReblogsNotification(bool enable) async {
    await _prefs.setBool(SettingsKeys.enableReblogsNotification, enable);
  }

  bool getEnableReblogsNotification() {
    return _prefs.getBool(SettingsKeys.enableReblogsNotification) ??
        SettingsDefaultValues.enableReblogsNotification;
  }

  Future<void> setEnableMentionsNotification(bool enable) async {
    await _prefs.setBool(SettingsKeys.enableMentionsNotification, enable);
  }

  bool getEnableMentionsNotification() {
    return _prefs.getBool(SettingsKeys.enableMentionsNotification) ??
        SettingsDefaultValues.enableMentionsNotification;
  }

  Future<void> setEnableFollowsNotification(bool enable) async {
    await _prefs.setBool(SettingsKeys.enableFollowsNotification, enable);
  }

  bool getEnableFollowsNotification() {
    return _prefs.getBool(SettingsKeys.enableFollowsNotification) ??
        SettingsDefaultValues.enableFollowsNotification;
  }
}
