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
  @EnviedField(varName: 'FIREBASE_API_KEY_ANDROID', obfuscate: true)
  static String firebaseAPIKeyAndroid = _Env.firebaseAPIKeyAndroid;
  @EnviedField(varName: 'FIREBASE_APP_ID_ANDROID', obfuscate: true)
  static String firebaseAppIdAndroid = _Env.firebaseAppIdAndroid;
  @EnviedField(varName: 'FIREBASE_API_KEY_IOS', obfuscate: true)
  static String firebaseAPIKeyIOS = _Env.firebaseAPIKeyIOS;
  @EnviedField(varName: 'FIREBASE_APP_ID_IOS', obfuscate: true)
  static String firebaseAppIdIOS = _Env.firebaseAppIdIOS;
  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID', obfuscate: true)
  static String firebaseMessagingSenderId = _Env.firebaseMessagingSenderId;
}
