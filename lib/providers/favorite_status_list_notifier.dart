import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pg_mobile/models/states/favorite_status_list_state.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';

final favoriteStatusListProvider =
    StateNotifierProvider<FavoriteStatusListNotifier, FavoriteStatusListState>(
        (ref) {
  return FavoriteStatusListNotifier();
});

class FavoriteStatusListNotifier
    extends StateNotifier<FavoriteStatusListState> {
  FavoriteStatusListNotifier() : super(defaultStatusListState);

  Future<void> fetchFavoriteStatusList() async {
    final newFavoriteStatusList =
        await MastodonRepository.instance.fetchFavoriteStatusList();
    final currentFavoriteStatusList = [...state.favoriteStatusList];
    currentFavoriteStatusList.addAll(newFavoriteStatusList);
    state = state.copyWith(favoriteStatusList: currentFavoriteStatusList);
  }
}
