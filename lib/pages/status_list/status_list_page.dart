import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/config/router.dart';

class StatusListPage extends ConsumerStatefulWidget {
  const StatusListPage({super.key});

  @override
  ConsumerState createState() => _StatusListPageState();
}

class _StatusListPageState extends ConsumerState<StatusListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () {
              context.go(AppPage.user.path);
            },
            child: const Text('User'),
          ),
          TextButton(
            onPressed: () {
              context.go(AppPage.hashTag.path);
            },
            child: const Text('Hash Tag'),
          ),
          TextButton(
            onPressed: () {
              context.go(AppPage.user.path);
            },
            child: const Text('Status Detail'),
          ),
          TextButton(
            onPressed: () {
              context.go(AppPage.boostUserList.path);
            },
            child: const Text('Boost User List'),
          ),
          TextButton(
            onPressed: () {
              context.go(AppPage.favoriteUserList.path);
            },
            child: const Text('Favorite User List'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.go(AppPage.createStatus.path);
        },
      ),
    );
  }
}
