import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/providers/signed_in_user_notifier.dart';

import '../provider_container.dart';

void main() {
  group('SignedInUserNotifier', () {
    test('build', () {
      final container = createContainer();
      final notifier = container.read(signedInUserNotifierProvider.notifier);

      expect(notifier.state, initialAccount);
    });
  });
}
