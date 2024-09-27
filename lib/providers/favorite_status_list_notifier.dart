import 'package:pg_mobile/models/states/favorite_status_list_state.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_status_list_notifier.g.dart';

@riverpod
class FavoriteStatusListNotifier extends _$FavoriteStatusListNotifier {
  @override
  FavoriteStatusListState build() {
    return initialFavoriteStatusListState;
  }

  Future<void> fetchFavoriteStatusList() async {
    final statuses =
        await MastodonRepository.instance.fetchFavoriteStatusList();
    state = state.copyWith(statuses: statuses);
  }
}
