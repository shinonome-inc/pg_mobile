import 'package:dio/dio.dart';
import 'package:pg_mobile/config/env.dart';
import 'package:pg_mobile/models/pgn_unit.dart';
import 'package:pg_mobile/models/pgn_user.dart';
import 'package:pg_mobile/util/date_formatter.dart';

class PGNRepository {
  PGNRepository._privateConstructor();

  static final PGNRepository _instance = PGNRepository._privateConstructor();
  static PGNRepository get instance => _instance;
  late Dio _dio;
  Dio get dio => _dio;
  Map<String, dynamic>? _headers;
  Map<String, dynamic>? get headers => _headers;

  void init() {
    BaseOptions options = BaseOptions(
      baseUrl: Env.pgnAPIBaseUrl,
    );

    _dio = Dio(options);
  }

  Future<List<PGNUser>> getUsers({
    required DateTime start,
    required DateTime end,
    PGNUnit unit = PGNUnit.day,
  }) async {
    if (start.isAfter(end)) {
      throw ArgumentError('start must be before end');
    }
    final Map<String, Object> params = {
      'start': DateFormatter.formatPGNDate(start),
      'end': DateFormatter.formatPGNDate(end),
      'unit': unit.text,
    };
    final response = await _dio.get('/reports', queryParameters: params);
    if (response.statusCode == 200) {
      final users = List<dynamic>.from(response.data);
      return users.map((e) => PGNUser.fromJson(e)).toList();
    } else {
      throw Exception(
        'Failed to fetch PGN users with status code: ${response.statusCode}',
      );
    }
  }
}
