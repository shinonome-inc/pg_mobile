import 'package:dio/dio.dart';
import 'package:pg_mobile/config/env.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/repository/secure_storage_repository.dart';

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
  String timelineEndpoint = "/api/v1/timelines/home?limit=40";

  void init() {
    BaseOptions options = BaseOptions(baseUrl: "https://community.4nonome.com");
    _dio = Dio(options);
  }

  Future<void> set(String accessToken) async {
    print('set');
    _headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $accessToken',
    };
    _dio.options.headers.addAll(_headers!);
    await SecureStorageRepository.writeToken(accessToken);
    print(accessToken);
  }

  Future<void> reset() async {
    print('reset');
    _headers = {};
    _dio.options.headers.addAll(_headers!);
    await SecureStorageRepository.deleteToken();
    final token = await SecureStorageRepository.readToken();
    print(token);
  }

  Future<String?> signIn(Uri uri) async {
    final code = uri.queryParameters['code'];
    final response = await _dio.post(
      '/oauth/token',
      data: {
        'client_id': Env.mastodonClientId,
        'client_secret': Env.mastodonClientSecret,
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': Env.mastodonRedirectUri,
      },
    );

    final body = response.data;
    final accessToken = body['access_token'];
    await set(accessToken);
    return accessToken;
  }

  Future<List<Account>> fetchFollowerList() async {
    final response = await _dio.get("/api/v1/accounts/219/followers?limit=80");
    if (response.statusCode == 200) {
      final users = List<dynamic>.from(response.data);
      return users.map((user) => Account.fromJson(user)).toList();
    } else {
      throw Exception(
        'Failed to fetch followers with status code ${response.statusCode}',
      );
    }
  }

  Future<List<Account>> fetchFollowList() async {
    final response = await _dio.get('/api/v1/accounts/219/following?limit=80');
    if (response.statusCode == 200) {
      final users = List<dynamic>.from(response.data);
      return users.map((user) => Account.fromJson(user)).toList();
    } else {
      throw Exception(
        'Failed to fetch followings with status code ${response.statusCode}',
      );
    }
  }

  Future<Account> fetchUser(String userId) async {
    final response = await _dio.get('/api/v1/accounts/$userId');
    if (response.statusCode == 200) {
      final user = Account.fromJson(response.data);
      return user;
    } else {
      throw Exception(
        'Failed to fetch user with status code ${response.statusCode}',
      );
    }
  }

  Future<List<Status>> fetchStatus() async {
    try {
      final response = await _dio.get(timelineEndpoint);
      // ページネーションの際はレスポンスヘッダのlinkにあるエンドポイントを使うため、Statusをとる時に次のページのエンドポイントを取得する
      final nextPageLink = response.headers["link"]![0];
      final link = nextPageLink.split('<');
      final nextPageUrl = link[1].split('>');
      final nextPageEndpoint = nextPageUrl[0].split('com');
      timelineEndpoint = nextPageEndpoint[2];
      final statuses = List<dynamic>.from(response.data);
      return statuses.map((status) => Status.fromJson(status)).toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<Status> favoriteStatus(String id) async {
    final response = await _dio.post('/api/v1/statuses/$id/favourite');
    if (response.statusCode == 200) {
      final status = Status.fromJson(response.data);
      return status;
    } else {
      throw Exception(
        'Failed to favorite status with status code ${response.statusCode}',
      );
    }
  }

  Future<Status> undoFavoriteStatus(String id) async {
    final response = await _dio.post('/api/v1/statuses/$id/unfavourite');
    if (response.statusCode == 200) {
      final status = Status.fromJson(response.data);
      return status;
    } else {
      throw Exception(
        'Failed to undo favorite status with status code ${response.statusCode}',
      );
    }
  }
}
