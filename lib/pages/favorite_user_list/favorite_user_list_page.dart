import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/config/router.dart';

class FavoriteUserListPage extends ConsumerStatefulWidget {
  const FavoriteUserListPage({super.key});

  @override
  ConsumerState createState() => _FavoriteUserListPageState();
}

class _FavoriteUserListPageState extends ConsumerState<FavoriteUserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite User List Page'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.push(AppPage.user.path);
          },
          child: const Text('User'),
        ),
      ),
    );
  }
}
