import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:pg_mobile/config/env.dart';
import 'package:pg_mobile/models/follower_model.dart';

class MastodonRepository {
  MastodonRepository._privateConstructor();
  static final MastodonRepository _instance =
      MastodonRepository._privateConstructor();
  static MastodonRepository get instance => _instance;
  late Dio _dio;
  Dio get dio => _dio;
  Map<String, dynamic>? _headers;
  Map<String, dynamic>? get headers => _headers;
  final url =
      "${Env.mastodonInstanceUrl}/oauth/authorize?response_type=code&client_id=${Env.mastodonClientId}&redirect_uri=${Env.mastodonRedirectUri}";

  void init() {
    BaseOptions options = BaseOptions(baseUrl: "https://community.4nonome.com");
    _dio = Dio(options);
  }

  void set(String accessToken) {
    _headers = {
      "Authorization": "Bearer $accessToken",
    };
    _dio.options.headers.addAll(_headers!);
  }

  Future<List<FollowerModel>> fetchFollowerList() async {
    final response = await _dio.get("/api/v1/accounts/219/followers?limit=80");
    final followerModel = List<dynamic>.from(response.data);
    return followerModel.map((e) => FollowerModel.fromJson(e)).toList();
  }

  Future<String?> signIn(Uri uri) async {
    final code = uri.queryParameters['code'];
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
      print(accessToken);
      return accessToken;
    } else {
      throw Exception('code does not have');
    }
  }
}
