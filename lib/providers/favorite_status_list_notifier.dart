import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pg_mobile/models/mastodon/favorite_status_list.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';

final favoriteStatusListProvider =
    StateNotifierProvider<FavoriteStatusListNotifier, FavoriteStatusList>(
        (ref) {
  return FavoriteStatusListNotifier();
});

class FavoriteStatusListNotifier extends StateNotifier<FavoriteStatusList> {
  FavoriteStatusListNotifier() : super(const FavoriteStatusList());

  Future<void> fetchFavoriteStatusList() async {
    final newFavoriteStatusList =
        await MastodonRepository.instance.fetchFavoriteStatusList();
    final currentFavoriteStatusList = [...state.favoriteStatusList];
    currentFavoriteStatusList.addAll(newFavoriteStatusList);
    state = state.copyWith(favoriteStatusList: currentFavoriteStatusList);
  }
}
