import 'package:pg_mobile/config/env.dart';

mixin EnvMixin {
  String get mastodonClientId => Env.mastodonClientId;
  String get mastodonClientSecret => Env.mastodonClientSecret;
  String get mastodonRedirectUri => Env.mastodonRedirectUri;
  String get mastodonInstanceUrl => Env.mastodonInstanceUrl;
}
