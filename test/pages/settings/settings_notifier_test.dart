import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/models/enums/publishing_level.dart';
import 'package:pg_mobile/models/enums/timeline_type.dart';
import 'package:pg_mobile/pages/settings/settings_notifier.dart';
import 'package:pg_mobile/pages/settings/settings_state.dart';

import '../../provider_container.dart';

void main() {
  group('SettingsNotifier', () {
    group('build', () {
      test('正しく初期化が行われている', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state, initialSettingsState);
      });
    });

    group('selectDefaultTimelineType', () {
      test('localを選択できる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.defaultTimelineType, TimelineType.local);

        notifier.selectDefaultTimelineType(TimelineType.local);
        expect(notifier.state.defaultTimelineType, TimelineType.local);
      });

      test('homeを選択できる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.defaultTimelineType, TimelineType.local);

        notifier.selectDefaultTimelineType(TimelineType.home);
        expect(notifier.state.defaultTimelineType, TimelineType.home);
      });

      test('mediaを選択できる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.defaultTimelineType, TimelineType.local);

        notifier.selectDefaultTimelineType(TimelineType.media);
        expect(notifier.state.defaultTimelineType, TimelineType.media);
      });
    });

    group('selectPublishingLevel', () {
      test('publicを選択できる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.defaultPublishingLevel, PublishingLevel.public);

        notifier.selectDefaultPublishingLevel(PublishingLevel.public);
        expect(notifier.state.defaultPublishingLevel, PublishingLevel.public);
      });

      test('quietPublicを選択できる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.defaultPublishingLevel, PublishingLevel.public);

        notifier.selectDefaultPublishingLevel(PublishingLevel.quietPublic);
        expect(
            notifier.state.defaultPublishingLevel, PublishingLevel.quietPublic);
      });

      test('followersを選択できる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.defaultPublishingLevel, PublishingLevel.public);

        notifier.selectDefaultPublishingLevel(PublishingLevel.followers);
        expect(
            notifier.state.defaultPublishingLevel, PublishingLevel.followers);
      });

      test('specificPeopleを選択できる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.defaultPublishingLevel, PublishingLevel.public);

        notifier.selectDefaultPublishingLevel(PublishingLevel.specificPeople);
        expect(notifier.state.defaultPublishingLevel,
            PublishingLevel.specificPeople);
      });
    });

    group('switchEnableLikesNotification', () {
      test('trueからfalseに切り替えができる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.enableLikesNotification, true);

        notifier.switchEnableLikesNotification(false);
        expect(notifier.state.enableLikesNotification, false);
      });

      test('falseからtrueに切り替えができる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.enableLikesNotification, true);

        notifier.switchEnableLikesNotification(false);
        expect(notifier.state.enableLikesNotification, false);

        notifier.switchEnableLikesNotification(true);
        expect(notifier.state.enableLikesNotification, true);
      });
    });

    group('switchEnableReblogsNotification', () {
      test('trueからfalseに切り替えができる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.enableReblogsNotification, true);

        notifier.switchEnableReblogsNotification(false);
        expect(notifier.state.enableReblogsNotification, false);
      });

      test('falseからtrueに切り替えができる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.enableReblogsNotification, true);

        notifier.switchEnableReblogsNotification(false);
        expect(notifier.state.enableReblogsNotification, false);

        notifier.switchEnableReblogsNotification(true);
        expect(notifier.state.enableReblogsNotification, true);
      });
    });

    group('switchEnableMentionsNotification', () {
      test('trueからfalseに切り替えができる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.enableMentionsNotification, true);

        notifier.switchEnableMentionsNotification(false);
        expect(notifier.state.enableMentionsNotification, false);
      });

      test('falseからtrueに切り替えができる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.enableMentionsNotification, true);

        notifier.switchEnableMentionsNotification(false);
        expect(notifier.state.enableMentionsNotification, false);

        notifier.switchEnableMentionsNotification(true);
        expect(notifier.state.enableMentionsNotification, true);
      });
    });

    group('switchEnableFollowsNotification', () {
      test('trueからfalseに切り替えができる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.enableFollowsNotification, true);

        notifier.switchEnableFollowsNotification(false);
        expect(notifier.state.enableFollowsNotification, false);
      });

      test('falseからtrueに切り替えができる', () {
        final container = createContainer();
        final notifier = container.read(settingsNotifierProvider.notifier);

        expect(notifier.state.enableFollowsNotification, true);

        notifier.switchEnableFollowsNotification(false);
        expect(notifier.state.enableFollowsNotification, false);

        notifier.switchEnableFollowsNotification(true);
        expect(notifier.state.enableFollowsNotification, true);
      });
    });
  });
}
