import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/pages/timeline/timeline_notifier.dart';
import 'package:pg_mobile/pages/timeline/timeline_state.dart';

import '../../provider_container.dart';

void main() {
  group('TimelineNotifier', () {
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
  });
}
