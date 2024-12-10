import 'package:pg_mobile/pages/top/top_state.dart';
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
  /// サインインに成功した場合はアクセストークンを返す。
  ///
  Future<String?> signInFromUrl(String url) async {
    if (state.isLoading) return null;
    final uri = Uri.parse(url);
    if (uri.queryParameters['code'] == null) return null;
    String? accessToken;
    _setLoading(true);
    try {
      accessToken = await MastodonRepository.instance.obtainToken(uri);
    } catch (e) {
      accessToken = null;
    } finally {
      _setLoading(false);
    }
    return accessToken;
  }
}
