import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/repository/secure_storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signed_in_user_notifier.g.dart';

@riverpod
class SignedInUserNotifier extends _$SignedInUserNotifier {
  @override
  Account? build() {
    return null;
  }

  void _setSignedInUser(Account? user) {
    state = user;
  }

  Future<void> signIn(String accessToken) async {
    final user = await MastodonRepository.instance.fetchCredentialAccount();
    _setSignedInUser(user);
    MastodonRepository.instance.setToken(accessToken);
    await SecureStorageRepository.writeToken(accessToken);
  }

  Future<void> signOut() async {
    _setSignedInUser(null);
    final token = await SecureStorageRepository.readToken();
    if (token == null) return;
    await MastodonRepository.instance.revokeToken(token);
    MastodonRepository.instance.reset();
    await SecureStorageRepository.deleteToken();
  }

  Future<void> fetchUser() async {
    final user = await MastodonRepository.instance.fetchCredentialAccount();
    state = user;
  }
}
