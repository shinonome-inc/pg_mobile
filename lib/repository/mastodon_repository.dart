import 'package:dio/dio.dart';
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

  void init() {
    BaseOptions options = BaseOptions(baseUrl: "https://community.4nonome.com");
    _dio = Dio(options);
  }

  void set() {
    String accessToken = "wP1x0Hk2AAb182ZfAUnbzEc6oepvV3zNGJStYbHg44c";
    _headers = {
      "Authorization": "Bearer $accessToken",
    };
    _dio.options.headers.addAll(_headers!);
  }

  Future<List<FollowerModel>> fetchFollowerList() async {
    final response = await _dio.get("/api/v1/accounts/219/followers");
    final followerModel = List<dynamic>.from(response.data);
    return followerModel.map((e) => FollowerModel.fromJson(e)).toList();
  }
}
