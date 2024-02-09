import 'package:pg_mobile/config/env.dart';

mixin EnvMixin {
  String get clientId => Env.clientId;
  String get clientSecret => Env.clientSecret;
  String get redirectUri => Env.redirectUri;
  String get instanceUrl => Env.instanceUrl;
}
