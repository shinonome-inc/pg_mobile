import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pg_mobile/models/mastodon/credential_account.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';

final signInUserProvider =
    StateNotifierProvider<SignInUserNotifier, CredentialAccount?>(
  (ref) => SignInUserNotifier(ref),
);

class SignInUserNotifier extends StateNotifier<CredentialAccount?> {
  SignInUserNotifier(this.ref) : super(null);

  final Ref ref;

  void set(CredentialAccount? account) {
    state = account;
  }

  void reset() {
    set(null);
  }

  Future<void> update() async {
    final CredentialAccount account =
        await MastodonRepository.instance.fetchCredentialAccount();
    set(account);
  }
}
