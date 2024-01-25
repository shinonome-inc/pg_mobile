import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'USE_DEBUG_MODE')
  static const bool useDebugMode = _Env.useDebugMode;
}
