import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:pg_mobile/debug/util/env_mixin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginButton extends StatelessWidget with EnvMixin{
  const LoginButton({super.key});

  Future<void> signInWithMastodon() async {
    final url = Uri.parse('$instanceUrl/oauth/authorize?client_id=$clientId&response_type=code&redirect_uri=$redirectUri&scope=read');

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: "pgmobile");

    final code = Uri.parse(result).queryParameters['code'];
    if (code != null) {
      final response = await http.post(
        Uri.parse('$instanceUrl/oauth/token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': redirectUri,
        },
      );

      final accessToken = json.decode(response.body)['access_token'];
      if (accessToken != null) {
        // アクセストークンを使用して、Mastodon APIの認証が必要な操作を行う
        debugPrint('Access Token: $accessToken');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        signInWithMastodon();
      },
      child: const Text('Sign in with Mastodon'),
    );
  }
}
