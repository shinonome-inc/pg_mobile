import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/models/states/timeline_state.dart';
import 'package:pg_mobile/providers/timeline_notifier.dart';

import '../provider_container.dart';

void main() {
  group('TimelineNotifier', () {
    final mockAccount1 = Account(
      id: '1',
      username: 'user1',
      acct: 'user1',
      displayName: 'User One',
      url: 'https://example.com/@user1',
      note: 'This is user1.',
      avatar: 'https://example.com/avatars/user1.png',
      avatarStatic: 'https://example.com/avatars/user1_static.png',
      header: 'https://example.com/headers/user1.png',
      headerStatic: 'https://example.com/headers/user1_static.png',
      locked: false,
      fields: [],
      emojis: [],
      bot: false,
      group: false,
      createdAt: DateTime(2020, 1, 1),
      lastStatusAt: DateTime(2024, 1, 1),
      statusesCount: 100,
      followersCount: 100,
      followingCount: 100,
    );

    final mockAccount2 = Account(
      id: '2',
      username: 'user2',
      acct: 'user2',
      displayName: 'User Two',
      url: 'https://example.com/@user2',
      note: 'This is user2.',
      avatar: 'https://example.com/avatars/user2.png',
      avatarStatic: 'https://example.com/avatars/user2_static.png',
      header: 'https://example.com/headers/user2.png',
      headerStatic: 'https://example.com/headers/user2_static.png',
      locked: false,
      fields: [],
      emojis: [],
      bot: false,
      group: false,
      createdAt: DateTime(2020, 2, 2),
      lastStatusAt: DateTime(2024, 2, 2),
      statusesCount: 200,
      followersCount: 200,
      followingCount: 200,
    );

    final mockStatus1 = Status(
      id: '1',
      uri: 'https://example.com/status/1',
      createdAt: '2024-01-01T12:00:00Z',
      account: mockAccount1,
      content: 'This is a test status 1.',
      visibility: 'public',
      sensitive: false,
      spoilerText: '',
      mediaAttachments: [],
      mentions: [],
      tags: [],
      emojis: [],
      reblogsCount: 0,
      favouritesCount: 0,
      repliesCount: 0,
    );

    final mockStatus2 = Status(
      id: '2',
      uri: 'https://example.com/status/2',
      createdAt: '2024-02-02T12:00:00Z',
      account: mockAccount2,
      content: 'This is a test status 2.',
      visibility: 'unlisted',
      sensitive: true,
      spoilerText: 'Spoiler!',
      mediaAttachments: [],
      mentions: [],
      tags: [],
      emojis: [],
      reblogsCount: 1,
      favouritesCount: 1,
      repliesCount: 2,
    );

    final mockStatuses = [mockStatus1, mockStatus2];

    test('build', () {
      final container = createContainer();
      final notifier = container.read(timelineNotifierProvider.notifier);

      expect(notifier.state, initialTimelineState);
    });

    test('setLoading', () {
      final container = createContainer();
      final notifier = container.read(timelineNotifierProvider.notifier);

      expect(notifier.state.isLoading, false);

      notifier.setLoading(true);
      expect(notifier.state.isLoading, true);

      notifier.setLoading(false);
      expect(notifier.state.isLoading, false);
    });

    test('setStatuses', () {
      final container = createContainer();
      final notifier = container.read(timelineNotifierProvider.notifier);

      expect(notifier.state.statuses, []);

      notifier.setStatuses(mockStatuses);
      expect(notifier.state.statuses, mockStatuses);
    });

    test('setStatus', () {
      final container = createContainer();
      final notifier = container.read(timelineNotifierProvider.notifier);

      notifier.setStatuses(mockStatuses);
      final updatedStatus = mockStatus1.copyWith(content: "Updated content");
      notifier.setStatus(updatedStatus);

      final actualStatus =
          notifier.state.statuses.firstWhere((s) => s.id == updatedStatus.id);
      final matcherStatus = mockStatus1.copyWith(content: "Updated content");
      expect(actualStatus, matcherStatus);
    });

    test('addStatuses', () {
      final container = createContainer();
      final notifier = container.read(timelineNotifierProvider.notifier);

      expect(notifier.state.statuses, []);

      notifier.addStatuses(mockStatuses);
      expect(notifier.state.statuses, mockStatuses);
    });

    test('addStatus', () {
      final container = createContainer();
      final notifier = container.read(timelineNotifierProvider.notifier);

      expect(notifier.state.statuses, []);

      notifier.addStatus(mockStatus1);
      expect(notifier.state.statuses, [mockStatus1]);

      notifier.addStatus(mockStatus2);
      expect(notifier.state.statuses, [mockStatus2, mockStatus1]);
    });

    test('reset', () {
      final container = createContainer();
      final notifier = container.read(timelineNotifierProvider.notifier);

      expect(notifier.state, initialTimelineState);

      notifier.setStatuses(mockStatuses);
      expect(
        notifier.state,
        initialTimelineState.copyWith(statuses: mockStatuses),
      );

      notifier.reset();
      expect(notifier.state, initialTimelineState);
    });
  });
}
