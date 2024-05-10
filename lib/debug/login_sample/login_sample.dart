import 'package:flutter/material.dart';
import 'package:pg_mobile/debug/login_sample/login_button.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';
import 'package:pg_mobile/repository/secure_storage_repository.dart';

class LoginSample extends StatefulWidget {
  const LoginSample({super.key});

  @override
  State<LoginSample> createState() => _LoginSampleState();
}

class _LoginSampleState extends State<LoginSample> {
  bool _isLoading = false;
  bool _hasSignIn = false;

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void _setSignIn(bool value) {
    setState(() {
      _hasSignIn = value;
    });
  }

  Future<void> _judgeSignIn() async {
    _setLoading(true);
    final token = await SecureStorageRepository.readToken();
    final hasSignIn = token != null && token.isNotEmpty;
    _setSignIn(hasSignIn);
    _setLoading(false);
  }

  Future<void> _signOut() async {
    if (_isLoading) return;
    _setLoading(true);
    await SecureStorageRepository.deleteToken();
    MastodonRepository.instance.reset();
    _setSignIn(false);
    _setLoading(false);
  }

  @override
  void initState() {
    super.initState();
    _judgeSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mastodon Login Example'),
      ),
      body: Center(
        child: _hasSignIn
            ? ElevatedButton(
                onPressed: _signOut,
                child: const Text('Sign Out'),
              )
            : const LoginButton(),
      ),
    );
  }
}
