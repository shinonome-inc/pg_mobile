import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:pg_mobile/debug/util/env_mixin.dart';

class MastdonRepository with EnvMixin {
  MastdonRepository._();

  static Future<void> signIn() async {
    final url = Uri.parse(
        '$mastodonInstanceUrl/oauth/authorize?client_id=$mastodonClientId&response_type=code&redirect_uri=$mastodonRedirectUri&scope=read');

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: "pgmobile");

    final code = Uri.parse(result).queryParameters['code'];
    if (code != null) {
      final response = await http.post(
        Uri.parse('$mastodonInstanceUrl/oauth/token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'client_id': mastodonClientId,
          'client_secret': mastodonClientSecret,
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': mastodonRedirectUri,
        },
      );

      final accessToken = json.decode(response.body)['access_token'];
      if (accessToken != null) {
        // アクセストークンを使用して、Mastodon APIの認証が必要な操作を行う
        debugPrint('Access Token: $accessToken');
      }
    }
  }
}
