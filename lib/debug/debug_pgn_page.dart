import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pg_mobile/debug/debug_pgn_user_item.dart';
import 'package:pg_mobile/models/pgn_user.dart';
import 'package:pg_mobile/repository/pgn_repository.dart';

class DebugPGNPage extends StatefulWidget {
  const DebugPGNPage({Key? key}) : super(key: key);

  @override
  State<DebugPGNPage> createState() => _DebugPGNPageState();
}

class _DebugPGNPageState extends State<DebugPGNPage> {
  bool _isLoading = false;
  bool _hasNetworkError = false;
  List<PGNUser> _users = [];

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

  void _setUsers(List<PGNUser> users) {
    users.sort((a, b) => a.total.compareTo(b.total));
    final reversedUsers = users.reversed.toList();
    setState(() {
      _users = reversedUsers;
    });
  }

  Future<void> _fetchUsers() async {
    _setLoading(true);
    _setNetworkError(false);
    final now = DateTime.now();
    try {
      final users = await PGNRepository.instance.getUsers(
        start: now.subtract(const Duration(days: 28)),
        end: now,
      );
      _setUsers(users);
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
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PGN'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : _hasNetworkError
                  ? const Text('PGNからデータを取得できませんでした。')
                  : ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users.elementAt(index);
                        return DebugPGNUserItem(ranking: index + 1, user: user);
                      },
                    ),
        ),
      ),
    );
  }
}
