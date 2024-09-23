import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/status.dart';

part 'favorite_status_list_state.freezed.dart';

@freezed
class FavoriteStatusListState with _$FavoriteStatusListState {
  const factory FavoriteStatusListState({
    required List<Status> favoriteStatusList,
  }) = _FavoriteStatusListState;
}

const FavoriteStatusListState defaultStatusListState = FavoriteStatusListState(
  favoriteStatusList: [],
);
