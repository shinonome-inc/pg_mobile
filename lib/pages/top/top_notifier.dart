import 'package:pg_mobile/pages/top/top_state.dart';
import 'package:pg_mobile/providers/signed_in_user_notifier.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'top_notifier.g.dart';

@riverpod
class TopNotifier extends _$TopNotifier {
  @override
  TopState build() {
    return initialTopState;
  }

  void _setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setWebViewHeight(double webViewHeight) {
    state = state.copyWith(webViewHeight: webViewHeight);
  }

  /// URLからサインインする。
  ///
  /// [url]にはMastodonの認証画面のURLを指定する。
  ///
  Future<void> signInFromUrl(String url) async {
    if (state.isLoading) return;

    final uri = Uri.parse(url);
    if (uri.queryParameters['code'] == null) return;

    _setLoading(true);
    try {
      final accessToken = await MastodonRepository.instance.obtainToken(uri);
      if (accessToken == null) return;
      await ref.read(signedInUserNotifierProvider.notifier).signIn(accessToken);
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    } finally {
      _setLoading(false);
    }
  }
}
