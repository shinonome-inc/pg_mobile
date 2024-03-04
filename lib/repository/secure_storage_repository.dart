import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  SecureStorageRepository._();

  static const _storage = FlutterSecureStorage();

  static const _tokenKey = 'access_token';

  static Future<String?> readToken() async {
    String? token;
    try {
      token = await _storage.read(key: _tokenKey);
    } catch (e) {
      debugPrint('Failed to read token: $e');
    }
    return token;
  }

  static Future<void> deleteToken() async {
    final token = await readToken();
    if (token == null || token.isEmpty) return;
    try {
      await _storage.delete(key: _tokenKey);
    } catch (e) {
      debugPrint('Failed to delete token: $e');
    }
  }

  static Future<void> writeToken(String? token) async {
    if (token == null) return;
    try {
      await _storage.write(key: _tokenKey, value: token);
    } catch (e) {
      debugPrint('Failed to write token: $e');
    }
  }
}
