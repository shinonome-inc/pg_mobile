import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';

final signedInUserProvider =
    StateNotifierProvider<SignedInUserNotifier, Account>((ref) {
  return SignedInUserNotifier();
});

class SignedInUserNotifier extends StateNotifier<Account> {
  SignedInUserNotifier() : super(defaultAccount);

  void reset() {
    state = defaultAccount;
  }

  Future<void> fetchUser() async {
    final user = await MastodonRepository.instance.fetchCredentialAccount();
    state = user;
  }
}
