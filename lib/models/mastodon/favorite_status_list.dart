import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/status.dart';

part 'favorite_status_list.freezed.dart';

@freezed
class FavoriteStatusList with _$FavoriteStatusList {
  const factory FavoriteStatusList({
    @Default([]) List<Status> favoriteStatusList,
  }) = _FavoriteStatusList;
}
