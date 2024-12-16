import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/pages/top/top_notifier.dart';
import 'package:pg_mobile/pages/top/top_state.dart';

import '../../provider_container.dart';

void main() {
  group('TopNotifier', () {
    test('build', () {
      final container = createContainer();
      final notifier = container.read(topNotifierProvider.notifier);

      expect(notifier.state, initialTopState);
    });

    test('setWebHeight', () {
      final container = createContainer();
      final notifier = container.read(topNotifierProvider.notifier);
      notifier.setWebViewHeight(400.0);

      expect(notifier.state.webViewHeight, 400.0);
    });
  });
}
