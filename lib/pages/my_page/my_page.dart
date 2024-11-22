import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pg_mobile/config/router.dart';

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  ConsumerState createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () {
              context.push(AppPage.followingList.path);
            },
            child: const Text('Following List'),
          ),
          TextButton(
            onPressed: () {
              context.push(AppPage.followerList.path);
            },
            child: const Text('Follower List'),
          ),
          TextButton(
            onPressed: () {
              // TODO: MediaPageを追加する。
            },
            child: const Text('Media'),
          ),
          TextButton(
            onPressed: () {
              context.push(AppPage.user.path);
            },
            child: const Text('User'),
          ),
          TextButton(
            onPressed: () {
              context.push(AppPage.hashTag.path);
            },
            child: const Text('Hash Tag'),
          ),
          TextButton(
            onPressed: () {
              context.push(AppPage.user.path);
            },
            child: const Text('Status Detail'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push(AppPage.createStatus.path);
        },
      ),
    );
  }
}
