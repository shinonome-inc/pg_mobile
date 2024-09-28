import 'package:flutter_test/flutter_test.dart';
import 'package:pg_mobile/models/states/favorite_status_list_state.dart';
import 'package:pg_mobile/providers/favorite_status_list_notifier.dart';

import '../provider_container.dart';

void main() {
  group('FavoriteStatusListNotifier', () {
    test('build', () {
      final container = createContainer();
      final notifier =
          container.read(favoriteStatusListNotifierProvider.notifier);

      expect(notifier.state, initialFavoriteStatusListState);
    });
  });
}
