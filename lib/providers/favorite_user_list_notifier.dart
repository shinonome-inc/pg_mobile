import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pg_mobile/models/mastodon/favorite_user_list.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';

final favoriteUserListProvider =
    StateNotifierProvider<FavoriteUserListNotifier, FavoriteUserList>((ref) {
  return FavoriteUserListNotifier();
});

class FavoriteUserListNotifier extends StateNotifier<FavoriteUserList> {
  FavoriteUserListNotifier() : super(const FavoriteUserList());

  Future<void> fetchFavoriteUserList(String statusId) async {
    state = state.copyWith(isLoading: true);
    final favoriteUserAccountList =
        await MastodonRepository.instance.fetchFavoriteUserList(statusId);
    state = state.copyWith(favoriteUserAccountList: favoriteUserAccountList);
    state = state.copyWith(isLoading: false);
  }

  void resetData() {
    state = state.copyWith(
      favoriteUserAccountList: [],
      isLoading: false,
    );
  }
}
