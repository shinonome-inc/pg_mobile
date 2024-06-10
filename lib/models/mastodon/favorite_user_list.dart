import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pg_mobile/models/mastodon/account.dart';

part 'favorite_user_list.freezed.dart';

@freezed
class FavoriteUserList with _$FavoriteUserList {
  const factory FavoriteUserList({
    @Default([]) List<Account> favoriteUserAccountList,
    @Default(false) bool isLoading,
  }) = _FavoriteUserList;
}
