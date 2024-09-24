import 'package:pg_mobile/models/states/favorite_status_list_state.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_status_list_notifier.g.dart';

@riverpod
class favoriteStatusListNotifier extends _$favoriteStatusListNotifier {
  @override
  FavoriteStatusListState build() {
    return defaultStatusListState;
  }

  Future<void> fetchFavoriteStatusList() async {
    final newFavoriteStatusList =
        await MastodonRepository.instance.fetchFavoriteStatusList();
    final currentFavoriteStatusList = [...state.favoriteStatusList];
    currentFavoriteStatusList.addAll(newFavoriteStatusList);
    state = state.copyWith(favoriteStatusList: currentFavoriteStatusList);
  }
}
