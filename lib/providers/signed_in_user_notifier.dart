import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signed_in_user_notifier.g.dart';

@riverpod
class SignedInUserNotifier extends _$SignedInUserNotifier {
  @override
  Account build() {
    return defaultAccount;
  }

  void reset() {
    state = defaultAccount;
  }

  Future<void> fetchUser() async {
    final user = await MastodonRepository.instance.fetchCredentialAccount();
    state = user;
  }
}
