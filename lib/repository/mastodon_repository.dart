import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pg_mobile/config/env.dart';
import 'package:pg_mobile/models/mastodon/account.dart';
import 'package:pg_mobile/models/mastodon/context.dart';
import 'package:pg_mobile/models/mastodon/status.dart';
import 'package:pg_mobile/repository/secure_storage_repository.dart';
import 'package:uuid/uuid.dart';

class MastodonRepository {
  MastodonRepository._privateConstructor();

  static final MastodonRepository _instance =
      MastodonRepository._privateConstructor();
  static MastodonRepository get instance => _instance;
  late Dio _dio;
  Dio get dio => _dio;
  Map<String, dynamic>? _headers;
  Map<String, dynamic>? get headers => _headers;

  String? _token;

  static const String _scope = 'read+write';

  static const String _baseUrl = 'https://community.4nonome.com';
  static final String authorizeUrl =
      '$_baseUrl/oauth/authorize?response_type=code&client_id=${Env.mastodonClientId}&redirect_uri=${Env.mastodonRedirectUri}&scope=$_scope';

  void init() {
    BaseOptions options = BaseOptions(baseUrl: _baseUrl);
    _dio = Dio(options);
  }

  Future<void> set(String accessToken) async {
    _headers = {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    };
    _dio.options.headers.addAll(_headers!);
    _token = accessToken;
    await SecureStorageRepository.writeToken(accessToken);
  }

  Future<void> reset() async {
    _headers = {};
    _dio.options.headers.addAll(_headers!);
    _token = null;
    await SecureStorageRepository.deleteToken();
  }

  Future<String?> obtainToken(Uri uri) async {
    final code = uri.queryParameters['code'];
    final response = await _dio.post(
      '/oauth/token',
      data: {
        'client_id': Env.mastodonClientId,
        'client_secret': Env.mastodonClientSecret,
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': Env.mastodonRedirectUri,
        'scopes': _scope,
      },
    );
    final body = response.data;
    final accessToken = body['access_token'];
    await set(accessToken);
    return accessToken;
  }

  Future<void> revokeToken() async {
    final response = await _dio.post(
      '/oauth/revoke',
      data: {
        'client_id': Env.mastodonClientId,
        'client_secret': Env.mastodonClientSecret,
        'token': _token,
      },
    );
    if (response.statusCode == 200) {
      await reset();
    } else {
      throw Exception(
        'Failed to revoke token with status code ${response.statusCode}',
      );
    }
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
    return accessToken;
  }

  Future<List<Status>> fetchFavoriteStatusList() async {
    String favoriteStatusListEndpoint = '/api/v1/favourites?limit=40';
    final response = await _dio.get(favoriteStatusListEndpoint);
    if (response.statusCode == 200) {
      final link = response.headers['link'];
      final nextPageLink = link![0];
      final nextPageUrlIncludeSmaller = nextPageLink.split('>')[0];
      final nextPageUrl = nextPageUrlIncludeSmaller.split('<')[1];
      final nextPageEndpoint = nextPageUrl.split('com')[2];
      favoriteStatusListEndpoint = nextPageEndpoint;
      final favoriteStatusList = List<dynamic>.from(response.data);
      return favoriteStatusList
          .map((status) => Status.fromJson(status))
          .toList();
    } else {
      throw Exception('response statusCode is ${response.statusCode}.');
    }
  }

  Future<Account> fetchCredentialAccount() async {
    final response = await _dio.get('/api/v1/accounts/verify_credentials');
    if (response.statusCode == 200) {
      final credentialAccount = Account.fromJson(response.data);
      return credentialAccount;
    } else {
      throw Exception(
        'Failed to fetch credential account. response status code is ${response.statusCode}. error message is ${response.statusMessage}.',
      );
    }
  }

  Future<List<Status>> fetchStatus() async {
    try {
      String endPoint = '/api/v1/timelines/home?limit=40';
      final response = await _dio.get(endPoint);
      // ページネーションの際はレスポンスヘッダのlinkにあるエンドポイントを使うため、Statusをとる時に次のページのエンドポイントを取得する
      final nextPageLink = response.headers["link"]![0];
      final link = nextPageLink.split('<');
      final nextPageUrl = link[1].split('>');
      final nextPageEndpoint = nextPageUrl[0].split('com');
      endPoint = nextPageEndpoint[2];
      final statuses = List<dynamic>.from(response.data);
      return statuses.map((status) => Status.fromJson(status)).toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<Context> fetchThread(String statusId) async {
    final response = await _dio.get('/api/v1/statuses/$statusId/context');
    if (response.statusCode == 200) {
      return Context.fromJson(response.data);
    } else {
      throw Exception(
        'Failed to fetch statuses in thread with status code ${response.statusCode}',
      );
    }
  }

  Future<Status> postNewStatus({
    required String text,
    required List<String> mediaIds,
    required List<String> poll,
    String? inReplyToId,
  }) async {
    final uuid = const Uuid().v4();
    _dio.options.headers.addAll({'Idempotency-Key': uuid});
    final data = {
      'status': text,
      'media_ids': mediaIds,
      'poll': poll,
    };
    if (inReplyToId != null) {
      data.addAll({'in_reply_to_id': inReplyToId});
    }
    final response = await _dio.post(
      '/api/v1/statuses',
      data: data,
    );
    _dio.options.headers.remove('Idempotency-Key');
    if (response.statusCode == 200) {
      final status = Status.fromJson(response.data);
      return status;
    } else {
      throw Exception(
        'Failed to post new status with status code ${response.statusCode}, response requestOptions: ${response.requestOptions}',
      );
    }
  }

  Future<Status> boostStatus(String id) async {
    final response = await _dio.post('/api/v1/statuses/$id/reblog');
    if (response.statusCode == 200) {
      final status = Status.fromJson(response.data);
      return status;
    } else {
      throw Exception(
        'Failed to boost status with status code ${response.statusCode}, response requestOptions: ${response.requestOptions}',
      );
    }
  }

  Future<Status> undoBoostStatus(String id) async {
    final response = await _dio.post('/api/v1/statuses/$id/unreblog');
    if (response.statusCode == 200) {
      final status = Status.fromJson(response.data);
      return status;
    } else {
      throw Exception(
        'Failed to undo boost status with status code ${response.statusCode}, response requestOptions: ${response.requestOptions}',
      );
    }
  }

  Future<Status> favoriteStatus(String id) async {
    final response = await _dio.post('/api/v1/statuses/$id/favourite');
    if (response.statusCode == 200) {
      final status = Status.fromJson(response.data);
      return status;
    } else {
      throw Exception(
        'Failed to favorite status with status code ${response.statusCode}, response requestOptions: ${response.requestOptions}',
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

  Future<void> deleteStatus(String id) async {
    final response = await _dio.delete('/api/v1/statuses/$id');
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to delete status with status code ${response.statusCode}',
      );
    }
  }

  Future<void> pinStatusToProfile(String id) async {
    final response = await _dio.post('/api/v1/statuses/$id/pin');
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to pin status to profile with status code ${response.statusCode}',
      );
    }
  }

  Future<void> unpinStatusToProfile(String id) async {
    final response = await _dio.post('/api/v1/statuses/$id/unpin');
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to unpin status from profile with status code ${response.statusCode}',
      );
    }
  }
}
