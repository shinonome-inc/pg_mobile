import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/models/mastodon_user.dart';
import 'package:pg_mobile/repository/mastodon_repository.dart';

class DebugMastodonUserPage extends StatefulWidget {
  const DebugMastodonUserPage({Key? key}) : super(key: key);

  @override
  State<DebugMastodonUserPage> createState() => _DebugMastodonUserPageState();
}

class _DebugMastodonUserPageState extends State<DebugMastodonUserPage> {
  late MastodonUser _user;
  bool _isLoading = false;
  bool _hasNetworkError = false;

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void _setNetworkError(bool value) {
    setState(() {
      _hasNetworkError = value;
    });
  }

  Future<void> _fetchUser() async {
    if (_isLoading) return;
    _setLoading(true);
    _setNetworkError(false);
    try {
      _user = await MastodonRepository.instance.fetchUser('262');
    } catch (e) {
      _setNetworkError(true);
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mastodon User'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _hasNetworkError
                ? const Text('ユーザーを取得できませんでした')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 160.w,
                        height: 160.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(_user.avatar),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(_user.displayName),
                    ],
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchUser,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
