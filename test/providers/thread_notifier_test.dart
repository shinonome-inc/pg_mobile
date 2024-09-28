import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/models/states/thread_state.dart';
import 'package:pg_mobile/providers/thread_notifier.dart';

import '../provider_container.dart';

void main() {
  group('ThreadNotifier', () {
    test('build', () {
      final container = createContainer();
      final notifier = container.read(threadNotifierProvider.notifier);

      expect(notifier.state, initialThreadState);
    });
  });
}
