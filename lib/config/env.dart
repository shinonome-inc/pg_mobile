import 'package:envied/envied.dart';

part 'env.g.dart';

/// .envファイルから読み取った環境変数を定数として扱うためのクラスです。
///
/// enviedを用いて.envから読み取った環境変数を難読化/暗号化してアプリに組み込むため、
/// 環境変数を難読化/暗号化せずアプリに組み込むdote_envより安全に管理できます。
///
/// 難読化/暗号化を行うには、@EnviedFieldのobfuscateをtrueに設定してください。
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'USE_DEBUG_MODE')
  static const bool useDebugMode = _Env.useDebugMode;
  @EnviedField(varName: 'PGN_API_BASE_URL', obfuscate: true)
  static String pgnAPIBaseUrl = _Env.pgnAPIBaseUrl;
  @EnviedField(varName: 'MASTODON_CLIENT_ID', obfuscate: true)
  static String mastodonClientId = _Env.mastodonClientId;
  @EnviedField(varName: 'MASTODON_CLIENT_SECRET', obfuscate: true)
  static String mastodonClientSecret = _Env.mastodonClientSecret;
  @EnviedField(varName: 'MASTODON_REDIRECT_URI', obfuscate: true)
  static String mastodonRedirectUri = _Env.mastodonRedirectUri;
  @EnviedField(varName: 'MASTODON_INSTANCE_URL', obfuscate: true)
  static String mastodonInstanceUrl = _Env.mastodonInstanceUrl;
}
