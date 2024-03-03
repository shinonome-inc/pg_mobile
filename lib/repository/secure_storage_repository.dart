import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  SecureStorageRepository._();

  static const _storage = FlutterSecureStorage();

  static const _tokenKey = 'access_token';

  /// 端末に保存されているアクセストークンを読み取ります。
  static Future<String?> readToken() async {
    String? token;
    try {
      token = await _storage.read(key: _tokenKey);
    } catch (e) {
      throw Exception('Failed to read token: $e');
    }
    return token;
  }

  /// 端末に保存されているアクセストークンを削除します。
  static Future<void> deleteToken() async {
    final token = await readToken();
    if (token == null || token.isEmpty) return;
    try {
      await _storage.delete(key: _tokenKey);
    } catch (e) {
      throw Exception('Failed to delete token: $e');
    }
  }

  /// 端末にアクセストークンを保存します。
  static Future<void> writeToken(String? token) async {
    if (token == null) return;
    try {
      await _storage.write(key: _tokenKey, value: token);
    } catch (e) {
      throw Exception('Failed to write token: $e');
    }
  }
}
