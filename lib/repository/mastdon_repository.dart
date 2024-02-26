import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:pg_mobile/config/env.dart';

class MastdonRepository {
  MastdonRepository._();

  static Future<void> signIn() async {
    final url = Uri.parse(
        '${Env.mastodonInstanceUrl}/oauth/authorize?client_id=${Env.mastodonClientId}&response_type=code&redirect_uri=${Env.mastodonRedirectUri}&scope=read');

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: "pgmobile");

    final code = Uri.parse(result).queryParameters['code'];
    if (code != null) {
      final response = await http.post(
        Uri.parse('${Env.mastodonInstanceUrl}/oauth/token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'client_id': Env.mastodonClientId,
          'client_secret': Env.mastodonClientSecret,
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': Env.mastodonRedirectUri,
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
