import 'package:pg_mobile/pages/top/top_state.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/repository/secure_storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'top_notifier.g.dart';

@riverpod
class TopNotifier extends _$TopNotifier {
  @override
  TopState build() {
    return initialTopState;
  }

  void setLoading(bool isLoading) {
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
    final uri = Uri.parse(url);
    if (uri.queryParameters['code'] == null) return null;
    final accessToken = await MastodonRepository.instance.obtainToken(uri);
    return accessToken;
  }

  Future<bool> isSignedIn() async {
    final token = await SecureStorageRepository.readToken();
    final isSignedIn = token != null && token.isNotEmpty;
    return isSignedIn;
  }
}
