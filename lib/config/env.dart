import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'USE_DEBUG_MODE')
  static const bool useDebugMode = _Env.useDebugMode;
  @EnviedField(varName: 'PGN_API_BASE_URL', obfuscate: true)
  static const String pgnAPIBaseUrl = _Env.pgnAPIBaseUrl;
}
